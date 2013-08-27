class Appointment < ActiveRecord::Base
  include NormalizesPhone

  belongs_to :day
  belongs_to :recipient

  validates :day,       :presence => true
  validates :recipient, :presence => true, :uniqueness => {:scope => :day_id}
end
