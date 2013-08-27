class Day < ActiveRecord::Base
  belongs_to :unit
  has_many   :appointments, :dependent => :destroy
  has_many   :recipients, :through => :appointments

  def appointment_data_for_recipient(recipient)
    appointment = appointments.where(recipient: recipient).first
    return {} unless appointment

    appointment.attributes
  end
end
