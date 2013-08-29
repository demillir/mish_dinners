class PersistedCalendar
  def initialize(unit, params)
    @unit   = unit
    @params = params
  end

  def save
    @params.each do |date_str, appointments_hash|
      appointments_hash.each do |recipient_number_str, appt_attrs|
        normalized_attrs = normalize_volunteer_attributes(appt_attrs)
        volunteer = @unit.volunteers.where(normalized_attrs).first_or_create!
        recipient = @unit.recipient_by_number(recipient_number_str.to_i)
        recipient.meals.
          where(date: date_str).
          first_or_initialize.
          update_attributes(type:      appt_attrs['type'].underscore.classify,
                            volunteer: volunteer)
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
