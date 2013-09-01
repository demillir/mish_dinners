class CalendarsController < ApplicationController
  before_action :set_unit,         only: [:show, :print, :edit, :update]
  before_action :authorize,        only: [:edit, :update]
  before_action :set_first_sunday, only: [:show, :print, :edit, :update]
  before_action :set_volunteer,    only: [:show, :print]

  def show
    @calendar = Calendar.new(@unit, @first_sunday, volunteer: @volunteer)
  end

  def print
    @calendar = Calendar.new(@unit, @first_sunday, volunteer: @volunteer)
  end

  def edit
    @calendar = Calendar.new(@unit, @first_sunday)
  end

  def update
    persisted_calendar = PersistedCalendar.new(@unit, params[:calendar])
    persisted_calendar.save

    flash[:notice] = 'The calendar has been updated.'
    @calendar = Calendar.new(@unit, @first_sunday)
    if params[:commit] =~ /print/i
      redirect_to print_calendar_url(@calendar, uuid: @calendar.unit_uuid, date: @calendar.start_date)
    else
      redirect_to  edit_calendar_url(@calendar, uuid: @calendar.unit_uuid, date: @calendar.start_date)
    end
  end

  private

  def authorize
    raise ActiveRecord::RecordNotFound unless params[:uuid].present?
    raise ActiveRecord::RecordNotFound unless params[:uuid] == @unit.uuid
  end

  def set_unit
    if params.has_key?(:division_abbr) && params.has_key?(:unit_abbr)
      division = Division.find_by_abbr(params[:division_abbr])
      @unit    = division.units.find_by_abbr(params[:unit_abbr])
    else
      @unit = Unit.find(params[:id])
    end
    raise ActiveRecord::RecordNotFound unless @unit
  end

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
