class Calendar
  include ActiveModel::Model

  attr_reader :unit

  delegate :coordinator_email, :to => :unit
  delegate :meal_time,         :to => :unit
  delegate :volunteer_pitch,   :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :abbr,              :to => :unit, :prefix => true
  delegate :uuid,              :to => :unit, :prefix => true

  def initialize(unit, first_sunday, options={})
    @unit = Unit.where(id: unit.try(:id)).
      includes(:division, recipients: {meals: :volunteer}).
      where(meals: {date: (first_sunday...first_sunday+21)}).
      first

    @first_sunday = first_sunday
    @privacy      = options[:privacy]
  end

  def weeks
    (0..2).map { |w|
      start_day = @first_sunday + w*7
      CalendarWeek.new(start_day, @unit, @privacy)
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

CalendarWeek = Struct.new(:start_date, :unit, :privacy) do
  include ActiveModel::Conversion

  def days
    (0..6).map { |d|
      date = start_date + d
      CalendarDay.new(date, (1..2).map { |i|
        appointment_data_hash = appointment_data_for_date_and_recipient_number(unit, date, i)
        CalendarAppointment.new(
          appointment_data_hash['name'],
          privacy ? nil : appointment_data_hash['phone'],
          privacy ? nil : appointment_data_hash['email'],
          appointment_data_hash['type'],
          appointment_data_hash['css_class'],
          i)
      })
    }
  end

  private

  def appointment_data_for_date_and_recipient_number(unit, date, recipient_number)
    meal = unit.recipient_by_number(recipient_number).meals.find { |meal| meal.date == date }
    meal.volunteer.attributes.merge('type' => meal.type, 'css_class' => meal.css_class)
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
