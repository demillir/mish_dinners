class StuffVolunteersAndMeals < ActiveRecord::Migration
  def up
    Appointment.includes(:recipient, :day => :unit).find_each do |appointment|
      unit = appointment.day.try(:unit)
      if unit
        volunteer = unit.volunteers.where(name: appointment.name, phone: appointment.phone, email: appointment.email).first_or_create!
        type = appointment.css_class.present? ? appointment.css_class.underscore.classify : 'InHome'
        appointment.recipient.meals.create!(date: appointment.date, volunteer: volunteer, type: type)
      end
    end
  end

  def down
    Volunteer.delete_all
    Meal.delete_all
  end
end
