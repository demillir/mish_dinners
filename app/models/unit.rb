class Unit < ActiveRecord::Base
  belongs_to :division
  has_many   :recipients, :dependent => :destroy
  has_many   :volunteers, :dependent => :destroy

  validates :division,          :presence => true
  validates :abbr,              :uniqueness => {:scope => :division_id, :case_sensitive => false}
  validates :coordinator_email, :presence => true
  validates :coordinator_name,  :presence => true

  delegate :abbr, :to => :division, :prefix => true

  def number_of_recipients
    recipients.size
  end

  def recipient_by_number(recipient_number)
    recipients.sort_by(&:id)[recipient_number-1]
  end
end
