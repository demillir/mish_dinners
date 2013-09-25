class Recipient < ActiveRecord::Base
  belongs_to :unit, :touch => true
  has_many   :meals, :dependent => :destroy

  validates :unit, :presence => true

  normalize_attribute :phone, with: :dashed_phone

  delegate :coordinator_email, :to => :unit
  delegate :coordinator_name,  :to => :unit
  delegate :reminder_subject,  :to => :unit
  delegate :meal_time,         :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :abbr,              :to => :unit, :prefix => true

  scope :for_unit, -> (unit) {
    where(unit_id: unit.id)
  }
end
