class Unit < ActiveRecord::Base
  belongs_to :division
  has_many   :recipients, :dependent => :destroy
  has_many   :volunteers, :dependent => :destroy
  has_many   :days, :dependent => :destroy

  validates :division,          :presence => true
  validates :abbr,              :uniqueness => {:scope => :division_id, :case_sensitive => false}
  validates :coordinator_email, :presence => true
  validates :coordinator_name,  :presence => true

  delegate :abbr, :to => :division, :prefix => true

  def appointment_data_for_date_and_recipient_number(date, recipient_number)
    day = days.find {|d| d.date == date }
    return {} unless day

    recipient = recipient_by_number(recipient_number)
    return {} unless recipient

    day.appointment_data_for_recipient(recipient)
  end

  def number_of_recipients
    @number_of_recipients ||= recipients.size
  end

  def recipient_data_for_recipient_number(recipient_number)
    recipient = recipient_by_number(recipient_number)
    return {} unless recipient

    recipient.attributes.merge('number' => recipient_number)
  end

  def recipient_by_number(recipient_number)
    recipients.sort_by(&:id)[recipient_number-1]
  end

  def names_list
    column_list(:name)
  end

  def phones_list
    column_list(:phone)
  end

  def emails_list
    column_list(:email)
  end

  private

  def column_list(column)
    volunteers.map(&column).find_all(&:present?).uniq.sort
  end
end
