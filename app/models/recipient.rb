class Recipient < ActiveRecord::Base
  include NormalizesPhone

  belongs_to :unit
  has_many   :meals, :dependent => :destroy
  has_many   :appointments, :dependent => :destroy
  has_many   :days, :through => :appointments

  validates :unit, :presence => true

  delegate :coordinator_email, :to => :unit
  delegate :coordinator_name,  :to => :unit
  delegate :reminder_subject,  :to => :unit
  delegate :meal_time,         :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :abbr,              :to => :unit, :prefix => true
end
