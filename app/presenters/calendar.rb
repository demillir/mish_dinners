class Calendar
  include ActiveModel::Model

  attr_reader :unit

  def initialize(unit, first_sunday, options={})
    @unit         = Unit.where(id: unit.try(:id)).includes(:division, :recipients, :days => :appointments).first
    @first_sunday = first_sunday
    @privacy      = options[:privacy]
  end

  delegate :coordinator_email, :to => :unit
  delegate :meal_time,         :to => :unit
  delegate :volunteer_pitch,   :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :division_abbr,     :to => :unit
  delegate :abbr,              :to => :unit, :prefix => true
  delegate :uuid,              :to => :unit, :prefix => true

  def weeks
    (0..2).map { |w|
      start_day = @first_sunday + w*7
      CalendarWeek.new(start_day, @unit, @privacy)
    }
  end

  def recipients
    (1..@unit.number_of_recipients).map { |i|
      recipient_data_hash = @unit.recipient_data_for_recipient_number(i)
      CalendarRecipient.new(
        recipient_data_hash['number'],
        recipient_data_hash['phone']
      )
    }
  end
end

CalendarWeek = Struct.new(:start_date, :unit, :privacy?) do
  include ActiveModel::Conversion

  def days
    (0..6).map { |d|
      date = start_date + d
      CalendarDay.new(date, (1..2).map { |i|
        appointment_data_hash = unit.appointment_data_for_date_and_recipient_number(date, i)
        CalendarAppointment.new(
          appointment_data_hash['name'],
          privacy? ? nil : appointment_data_hash['phone'],
          privacy? ? nil : appointment_data_hash['email'],
          appointment_data_hash['css_class'],
          i)
      })
    }
  end
end

CalendarDay = Struct.new(:date, :appointments) do
  include ActiveModel::Conversion
end

CalendarAppointment = Struct.new(:name, :phone, :email, :css_class, :recipient_number) do
  include ActiveModel::Conversion
end

CalendarRecipient = Struct.new(:number, :phone) do
  include ActiveModel::Conversion
end
