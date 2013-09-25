# Objects from this class are able to send email reminders to the volunteers providing meals on
# a given date.

class ReminderEmailer
  def initialize(target_date, unit=nil)
    @meals = meals_for_date(target_date, unit)
  end

  def send_reminders
    # Send a reminder email for each meal
    @meals.each do |meal|
      ReminderMailer.appointment_reminder(meal).deliver
    end
  end

  private

  def meals_for_date(date, unit)
    meal_scope = unit ? Meal.for_unit(unit) : Meal
    remindable_meals = meal_scope.remindable_for_date(date)

    # Group the meals into equivalence classes,
    # where two meals are equivalent if they have the same set of recipients.
    equivalence_classes = remindable_meals.
      group_by { |meal| Set.new(meal.recipients) }.
      values

    # Pick one meal from each equivalence class
    equivalence_classes.map(&:first)
  end
end
