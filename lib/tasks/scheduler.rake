desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  # Gather all of the remindable meals for the day after tomorrow.
  remindable_meals = Meal.remindable_for_date(Date.today + 2)

  # Group the meals into equivalence classes,
  # where two meals are equivalent if they have the same set of recipients.
  equivalence_classes = remindable_meals.
    group_by { |meal| Set.new(meal.recipients) }.
    values

  # Pick one meal from each equivalence class
  meals = equivalence_classes.map(&:first)

  # Send a reminder email for each meal
  meals.each do |meal|
    ReminderMailer.appointment_reminder(meal).deliver
  end
end
