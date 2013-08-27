class CalendarsController < ApplicationController
  before_action :set_unit,         only: [:show]
  before_action :set_first_sunday, only: [:show]

  def index
    redirect_to '/lo/lo'
  end

  def show
    @calendar = Calendar.new(@unit, @first_sunday, privacy: !params.has_key?(:print))
  end

  private

  def set_unit
    division = Division.find_by_abbr(params[:division_abbr])
    @unit    = division.units.find_by_abbr(params[:unit_abbr])
    raise ActiveRecord::RecordNotFound unless @unit
  end

  def set_first_sunday
    today         = Date.today
    @first_sunday = today - today.wday
    @first_sunday += 7 if params.has_key?(:next)
    @first_sunday -= 7 if params.has_key?(:prev)
  end
end
