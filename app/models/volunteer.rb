class Volunteer < ActiveRecord::Base
  include NormalizesPhone

  belongs_to :unit
  has_many   :meals, :dependent => :destroy

  validates :unit, :presence => true

  scope :having_email, -> {
    where.not(email: nil).
      where.not(email: '')
  }

  scope :having_no_meals, -> {
    includes(:meals).
      where(meals: {id: nil})
  }
end
