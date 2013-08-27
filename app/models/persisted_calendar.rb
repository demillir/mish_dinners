class PersistedCalendar
  def initialize(unit, params)
    @unit   = unit
    @params = params
  end

  def save
    @params.each do |date_str, appointments_hash|
      day = @unit.days.where(date: date_str).first_or_create
      save_day_appointments(day, appointments_hash)
    end
    true
  end

  private

  def save_day_appointments(day, appointments_hash)
    appointments_hash.each do |recipient_number_str, appt_attrs|
      recipient = @unit.recipient_by_number(recipient_number_str.to_i)
      appointment = day.appointments.where(recipient: recipient).first_or_create
      appointment.update_attributes(appt_attrs)
    end
  end
end
