class ReminderEmailingsController < ApplicationController
  protect_from_forgery except: :create

  before_action :set_unit
  before_action :authorize

  def create
    # Just as the CalendarsController#update action persists the data for an entire calendar page,
    # this action persists the data for a single calendar day.  The data for that single calendar day
    # comes in the params[:calendar] element.
    persisted_calendar = PersistedCalendar.new(@unit, params[:calendar])
    persisted_calendar.save

    target_date = Date.parse(params[:date]) rescue nil
    if target_date
      email_recipients = ReminderEmailer.new(target_date, @unit).send_reminders
      sent_descriptions = email_recipients.empty? \
        ? ["0 emails"] \
        : email_recipients.map { |email| "an email to #{email}" }
      render :json => {info: "Sent #{sent_descriptions.to_sentence}"}
    else
      head :unprocessable_entity
    end
  end
end
