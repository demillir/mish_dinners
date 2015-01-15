class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def set_unit
    if params.has_key?(:division_abbr) && params.has_key?(:unit_abbr)
      division = Division.find_by_abbr!(params[:division_abbr])
      @unit    = division.units.find_by_abbr!(params[:unit_abbr])
    elsif params.has_key?(:calendar_id)
      @unit = Unit.find(params[:calendar_id])
    else
      @unit = Unit.find(params[:id])
    end
  end

  def authorize
    raise ActiveRecord::RecordNotFound unless params[:uuid].present?
    raise ActiveRecord::RecordNotFound unless params[:uuid] == @unit.uuid
  end

end

#mortarstone
