class CalendarsController < ApplicationController
  before_action :set_unit,         only: [:show, :edit, :update]
  before_action :authorize,        only: [:edit, :update]
  before_action :set_first_sunday, only: [:show, :edit]

  def index
    redirect_to '/lo/lo'
  end

  def show
    @calendar = Calendar.new(@unit, @first_sunday, privacy: !params.has_key?(:print))
  end

  def edit
    @calendar = Calendar.new(@unit, @first_sunday)
  end

  def update
    @calendar = PersistedCalendar.new(@unit, params[:calendar])
    @calendar.save
    redirect_to url_for("/#{@unit.division_abbr}/#{@unit.abbr}?print")
  end

  private

  def authorize
    raise ActiveRecord::RecordNotFound unless params[:uuid].present?
    raise ActiveRecord::RecordNotFound unless params[:uuid] == @unit.uuid
  end

  def set_unit
    division = Division.find_by_abbr(params[:division_abbr])
    @unit    = division.units.find_by_abbr(params[:unit_abbr])
    raise ActiveRecord::RecordNotFound unless @unit
  end

  def set_first_sunday
    today         = Date.parse(params[:date]) rescue Date.today
    @first_sunday = today - today.wday
    @first_sunday += 7 if params.has_key?(:next)
    @first_sunday -= 7 if params.has_key?(:prev)
  end
end
