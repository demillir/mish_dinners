class Volunteer < ActiveRecord::Base
  belongs_to :unit, :touch => true
  has_many   :meals, :dependent => :destroy

  validates :unit, :presence => true

  normalize_attribute :phone, with: :dashed_phone

  scope :having_email, -> {
    where.not(email: nil)
  }

  scope :having_no_meals, -> {
    includes(:meals).
      where(meals: {id: nil})
  }
end
