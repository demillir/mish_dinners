class CalendarsController < ApplicationController
  #before_action :set_unit, only: [:show]

  def index
    redirect_to '/lo/lo'
  end

  def show
  end

  private

  def set_unit
    division = Division.find_by_abbr(params[:division_abbr])
    @unit    = division.units.find_by_abbr(params[:unit_abbr])
  end
end
