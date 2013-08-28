desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  # Gather all of the remindable appointments for the day after tomorrow.
  remindable_appointments = Appointment.
    where.not(email: nil).
    where.not(email: '').
    for_date(Date.today + 2)

  # Group the appointments into equivalence classes,
  # where two appointments are equivalent if they have the same set of recipients.
  equivalence_classes = remindable_appointments.
    group_by { |appointment| Set.new(appointment.all_similar_recipients) }.
    values

  # Pick one appointment from each equivalence class
  appointments = equivalence_classes.map(&:first)

  # Send a reminder email for each appointment
  appointments.each do |appointment|
    ReminderMailer.appointment_reminder(appointment).deliver
  end
end
