class Appointment < ActiveRecord::Base
  include NormalizesPhone

  belongs_to :day
  belongs_to :recipient

  validates :day,       :presence => true
  validates :recipient, :presence => true, :uniqueness => {:scope => :day_id}

  delegate :coordinator_email, :to => :recipient
  delegate :coordinator_name,  :to => :recipient
  delegate :reminder_subject,  :to => :recipient
  delegate :meal_time,         :to => :recipient
  delegate :division_abbr,     :to => :recipient
  delegate :unit_abbr,         :to => :recipient
  delegate :date,              :to => :day

  scope :for_date, -> (date) {
    joins(:day)
    .merge(Day.where(date: date))
  }

  scope :similar_to, -> (appointment) {
    for_date(appointment.date)
    .where(name: appointment.name, css_class: appointment.css_class)
  }

  def all_similar_recipients
    self.class.similar_to(self).map(&:recipient)
  end
end
