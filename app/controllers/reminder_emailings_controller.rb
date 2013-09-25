class ReminderEmailingsController < ApplicationController
  protect_from_forgery except: :create

  before_action :set_unit
  before_action :authorize

  def create
    target_date = Date.parse(params[:date]) rescue nil
    if target_date
      ReminderEmailer.new(target_date, @unit).send_reminders
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
