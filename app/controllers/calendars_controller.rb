class CalendarsController < ApplicationController
  before_action :set_unit,         only: [:show, :print, :edit, :update]
  before_action :authorize,        only: [       :print, :edit, :update]
  before_action :set_first_sunday, only: [:show, :print, :edit, :update]
  before_action :set_volunteer,    only: [:show, :print]

  def show
    @calendar = Calendar.new(@unit, @first_sunday, volunteer: @volunteer)
  end

  def print
    @pages_count = [params[:pages_count].to_i, 1].max
    @calendar = Calendar.new(@unit, @first_sunday, volunteer: @volunteer, pages_count: @pages_count)
  end

  def edit
    @calendar = Calendar.new(@unit, @first_sunday)
  end

  def update
    persisted_calendar = PersistedCalendar.new(@unit, params[:calendar])
    persisted_calendar.save

    @calendar = Calendar.new(@unit, @first_sunday)
    if params[:commit] =~ /print/i
      flash[:notice] = 'The calendar has been updated.'
      redirect_to print_calendar_url(@calendar, uuid: @calendar.unit_uuid, date: @calendar.start_date,
                                     pages_count: params[:pages_count], format: :pdf)
    elsif params[:commit] == "<="
      redirect_to  edit_calendar_url(@calendar, uuid: @calendar.unit_uuid, date: params[:adjacent][:left])
    elsif params[:commit] == "=>"
      redirect_to  edit_calendar_url(@calendar, uuid: @calendar.unit_uuid, date: params[:adjacent][:right])
    else
      flash[:notice] = 'The calendar has been updated.'
      redirect_to  edit_calendar_url(@calendar, uuid: @calendar.unit_uuid, date: @calendar.start_date)
    end
  end

  private

  def set_first_sunday
    today         = Date.parse(params[:date]) rescue Date.today
    @first_sunday = today - today.wday
    @first_sunday += 7 if params.has_key?(:next)
    @first_sunday -= 7 if params.has_key?(:prev)
  end

  def set_volunteer
    if params[:volunteer_id]
      @volunteer = Volunteer.where(id: params[:volunteer_id]).first
    end
  end
end
