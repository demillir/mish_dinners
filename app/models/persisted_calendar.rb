# Objects from this class take a hash table of incoming calendar data (from the calendar edit web page)
# and stuff the calendar data into the appropriate Volunteer and Meal database records.

class PersistedCalendar
  def initialize(unit, params)
    @unit   = unit
    @params = params
  end

  def save
    @params.each do |date_str, appointments_hash|
      appointments_hash.each do |recipient_number_str, appt_attrs|
        # Find or create a matching Volunteer record
        normalized_attrs = normalize_volunteer_attributes(appt_attrs)
        volunteer = @unit.volunteers.where(normalized_attrs).first_or_create!

        # The meal type is the camelcase version of the appointment's type
        meal_type = appt_attrs['type'].underscore.classify

        # Find or create a matching Meal record, and give it the Volunteer and meal type.
        recipient = @unit.recipient_by_number(recipient_number_str.to_i)
        recipient.meals.
          where(date: date_str).
          first_or_initialize.
          update_attributes(volunteer: volunteer, type: meal_type)
      end
    end

    # The saving of the appointment data may have left some Volunteer records dangling with no meal history.
    # Clean those up.
    @unit.volunteers.having_no_meals.destroy_all

    true
  end

  private

  # Before we search for an existing matching Volunteer record, normalize the search attributes
  # so we are comparing apples to apples.
  def normalize_volunteer_attributes(unnormalized_attrs)
    normalizer_obj = Volunteer.new(unnormalized_attrs.slice('name', 'phone', 'email'))
    normalizer_obj.attributes.slice('name', 'phone', 'email')
  end
end
