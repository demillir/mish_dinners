class ReminderMailer < ActionMailer::Base
  def appointment_reminder(appointment)
    mail(
      to:      'demillir@gmail.com',
      from:    'foo@app17751316.mailgun.org',
      subject: 'Do not forget'
    )
  end
end
