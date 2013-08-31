class SettingsController < ApplicationController
  before_action :set_unit,  only: [:edit, :update]
  before_action :authorize, only: [:edit, :update]

  def edit
    @calendar = Calendar.new(@unit)
  end

  def update
    if @settings.update(settings_params)
      calendar = Calendar.new(@unit)
      redirect_to edit_calendar_url(calendar, uuid: calendar.unit_uuid),
                  notice: 'Settings were successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def authorize
    raise ActiveRecord::RecordNotFound unless params[:uuid].present?
    raise ActiveRecord::RecordNotFound unless params[:uuid] == @unit.uuid
  end

  def set_unit
    @unit = Unit.find(params[:id])
    @settings = Settings.new(@unit)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def settings_params
    params.
      require(:settings).
      permit(:coordinator_name,
             :coordinator_email,
             :meal_time,
             :volunteer_pitch,
             :reminder_subject,
             :number_of_recipients,
             *((1..Rails.configuration.max_recipients).map {|i| "recipient#{i}_phone"}))
  end
end
