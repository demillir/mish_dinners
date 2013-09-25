desc "This task is called by the Heroku scheduler add-on"

task :send_reminders => :environment do
  # The target date is the day after tomorrow.
  ReminderEmailer.new(Date.today + 2).send_reminders
end
