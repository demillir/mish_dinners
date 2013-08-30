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

  def number_of_recipients=(val)
    return unless val.present?
    target = val.to_i
    return unless (1..3).include?(target)

    current_count = number_of_recipients

    while current_count > target do
      reload.recipients.sort_by(&:id).last.destroy
      current_count -= 1
    end

    while current_count < target do
      recipients.create!
      current_count += 1
    end
  end

  # Recipient numbers are 1-based.
  def recipient_by_number(recipient_number)
    recipients.sort_by(&:id)[recipient_number.to_i-1]
  end
end
