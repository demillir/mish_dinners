class Meal < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :volunteer, :touch => true
  belongs_to :recipient, :touch => true

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

  scope :for_unit, -> (unit) {
    joins(:recipient).
      merge(Recipient.for_unit(unit))
  }

  scope :remindable_for_date, -> (date) {
    joins(:volunteer).
      merge(Volunteer.having_email).
      where(date: date)
  }

  # Formats the given camelcase meal type, e.g. "InHome", as a CSS class, e.g. "in-home".
  # If the given meal type is blank, the type defaults to the first type in the application's list of meal types.
  def self.css_class_for_type(type)
    type_str = type.present? ? type : Figaro.env.meal_types.split.first
    type_str.underscore.dasherize
  end

  # Returns something like "in-home" or "sack"
  def css_class
    Meal.css_class_for_type(type)
  end

  # The default meal type is the first type in the application's list of meal types.
  def type
    read_attribute(:type) || Figaro.env.meal_types.split.first
  end

  # Returns a complete list of all the recipients receiving the same meal from the volunteer,
  # including this meal's recipient.
  def recipients
    self.class.
      where(volunteer_id: self.volunteer_id, date: self.date, type: self.type).
      map(&:recipient)
  end
end
