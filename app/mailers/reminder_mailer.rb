class ReminderMailer < ActionMailer::Base
  helper :application

  def appointment_reminder(appointment)
    @appointment = appointment
    return NullMail.new unless @appointment
    return NullMail.new unless @appointment.email.present?

    @recipients = @appointment.all_similar_recipients
    return NullMail.new unless @recipients.present?

    mail(
      to:      @appointment.email,
      from:    @appointment.coordinator_email,
      subject: @appointment.reminder_subject || 'Appointment reminder'
    )
  end
end
