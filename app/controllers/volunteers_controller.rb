class VolunteersController < ApplicationController
  protect_from_forgery except: :index
  respond_to :json

  before_action :set_unit
  before_action :authorize

  def index
    target_name = params[:name]
    @volunteers = target_name.present? ? fetch_volunteers(target_name) : []
    respond_with @volunteers
  end

  private

  # Return at most one volunteer, and make it the most recent volunteer having the given name.
  # Make the search case-insensitive.
  def fetch_volunteers(name)
    Meal.
      for_unit(@unit).
      joins(:volunteer).
      merge(Volunteer.name_like(name)).
      order(created_at: :desc).
      limit(1).
      map(&:volunteer)
  end
end
