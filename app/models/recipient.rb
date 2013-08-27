class Recipient < ActiveRecord::Base
  belongs_to :unit
  has_many   :appointments, :dependent => :destroy
  has_many   :days, :through => :appointments
end
