class Meal < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :volunteer
  belongs_to :recipient

  validates :type,      :presence => true
  validates :volunteer, :presence => true
  validates :recipient, :presence => true
  validates :date,      :presence => true
  validates :volunteer, :uniqueness => {scope: [:date, :recipient]}

  delegate :name,              :to => :volunteer, :prefix => true
  delegate :phone,             :to => :volunteer, :prefix => true
  delegate :email,             :to => :volunteer, :prefix => true
  delegate :coordinator_email, :to => :recipient
  delegate :coordinator_name,  :to => :recipient
  delegate :reminder_subject,  :to => :recipient
  delegate :meal_time,         :to => :recipient
  delegate :division_abbr,     :to => :recipient
  delegate :unit_abbr,         :to => :recipient

  scope :remindable_for_date, -> (date) {
    joins(:volunteer).
      merge(Volunteer.having_email).
      where(date: date)
  }

  def recipients
    self.class.
      where(volunteer_id: self.volunteer_id, date: self.date, type: self.type).
      map(&:recipient)
  end
end
