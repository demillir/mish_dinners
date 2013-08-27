class Day < ActiveRecord::Base
  belongs_to :unit
  has_many   :appointments, :dependent => :destroy
  has_many   :recipients, :through => :appointments

  validates :unit, :presence => true
  validates :date, :uniqueness => {:scope => :unit_id}

  def appointment_data_for_recipient(recipient)
    appointment = appointments.find { |appt| appt.recipient_id == recipient.try(:id) }
    return {} unless appointment

    appointment.attributes
  end
end
