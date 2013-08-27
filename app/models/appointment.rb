class Appointment < ActiveRecord::Base
  belongs_to :day
  belongs_to :recipient

  validates :day,       :presence => true
  validates :recipient, :presence => true, :uniqueness => {:scope => :day_id}
end
