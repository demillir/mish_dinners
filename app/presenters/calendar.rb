# This file defines several related classes that convert the Unit, Recipient, Volunteer, and Meal records
# for a calendar period into Calendar, CalendarWeek, CalendarDay, CalendarAppointment, and CalendarRecipient
# objects for use by the application's view layer.

class Calendar
  include ActiveModel::Model

  attr_reader :unit, :num_weeks_to_display, :privacy

  delegate :id,                :to => :unit
  delegate :to_param,          :to => :unit
  delegate :coordinator_email, :to => :unit
  delegate :meal_time,         :to => :unit
  delegate :volunteer_pitch,   :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :abbr,              :to => :unit, :prefix => true
  delegate :uuid,              :to => :unit, :prefix => true

  def initialize(unit, first_sunday, options={})
    # Eager load all of the records we need for the given unit's calendar, in two stages.
    # We have to do two stages because doing one stage was not possible in ActiveRelation
    # without losing the recipients who don't have meals scheduled during the calendar period.
    @unit = Unit.where(id: unit.try(:id)).
      includes(:division, :volunteers, :recipients).
      first
    @num_weeks_to_display = case @unit.number_of_recipients
                            when 1; 4
                            when 2; 3
                            when 3; 2
                            else;   1
                            end

    # Refetch each recipient, but this time, eager load the Meal records for the calendar period.
    @recipients = @unit.recipients.sort_by(&:id).map { |recipient|
      Recipient.where(id: recipient.id).
        includes(meals: :volunteer).
        where(meals: {date: (first_sunday...first_sunday+(7 * @num_weeks_to_display))}).
        first || recipient
    }

    @first_sunday = first_sunday
    @privacy      = options[:privacy]
  end

  # Calendars are completely derived from persisted data, so they can always be considered to be persisted.
  def persisted?
    true
  end

  def start_date
    weeks.first.days.first.date
  end

  def end_date
    weeks.last.days.last.date
  end

  def weeks
    (0...@num_weeks_to_display).map { |w|
      start_day = @first_sunday + w*7
      CalendarWeek.new(start_day, @unit, @recipients, @privacy)
    }
  end

  def recipients
    (1..@unit.number_of_recipients).map { |i|
      recipient_data_hash = recipient_data_for_recipient_number(@unit, i)
      CalendarRecipient.new(
        recipient_data_hash['number'],
        recipient_data_hash['phone']
      )
    }
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
    @unit.volunteers.map(&column).find_all(&:present?).uniq.sort
  end

  def recipient_data_for_recipient_number(unit, recipient_number)
    recipient = unit.recipient_by_number(recipient_number)
    return {} unless recipient

    recipient.attributes.merge('number' => recipient_number)
  end
end

CalendarWeek = Struct.new(:start_date, :unit, :recipients, :privacy) do
  include ActiveModel::Conversion

  def days
    (0..6).map { |d|
      date = start_date + d
      number_of_appointments = recipients.size
      appointments = (1..number_of_appointments).map { |recipient_number|
        make_appointment(recipients[recipient_number-1], recipient_number, date, privacy)
      }
      CalendarDay.new(date, appointments)
    }
  end

  private

  def make_appointment(recipient, recipient_number, date, privacy)
    appointment_data_hash = appointment_data_for_date_and_recipient_number(date, recipient)
    CalendarAppointment.new(
      appointment_data_hash['name'],
      privacy ? nil : appointment_data_hash['phone'],
      privacy ? nil : appointment_data_hash['email'],
      appointment_data_hash['type'],
      appointment_data_hash['css_class'],
      recipient_number)
  end

  def appointment_data_for_date_and_recipient_number(date, recipient)
    meal = recipient.meals.find { |meal| meal.date == date } || Meal.new
    attrs = meal.volunteer ? meal.volunteer.attributes : {}

    attrs.merge('type' => meal.type, 'css_class' => meal.css_class)
  end
end

CalendarDay = Struct.new(:date, :appointments) do
  include ActiveModel::Conversion
end

CalendarAppointment = Struct.new(:name, :phone, :email, :type, :css_class, :recipient_number) do
  include ActiveModel::Conversion
end

CalendarRecipient = Struct.new(:number, :phone) do
  include ActiveModel::Conversion
end
