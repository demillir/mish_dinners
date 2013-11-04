class ReminderMailer < ActionMailer::Base
  helper :application
  helper :calendar

  def appointment_reminder(meal)
    @meal = meal
    return NullMail.new unless @meal
    return NullMail.new unless @meal.volunteer_email.present?

    @meal_recipients = @meal.recipients
    return NullMail.new unless @meal_recipients.present?

    mail(
      to:      @meal.volunteer_email,
      from:    @meal.coordinator_email,
      subject: @meal.reminder_subject || 'Appointment reminder'
    )
  end
end
