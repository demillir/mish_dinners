class Appointment < ActiveRecord::Base
  belongs_to :day
  belongs_to :recipient
end
