class Recipient < ActiveRecord::Base
  include NormalizesPhone

  belongs_to :unit
  has_many   :appointments, :dependent => :destroy
  has_many   :days, :through => :appointments

  validates :unit, :presence => true
end
