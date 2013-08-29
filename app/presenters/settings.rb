# This model class combines the Unit and Recipient models into one object suitable for use in a view layer form.

class Settings
  include ActiveModel::Model

  attr_reader :unit

  delegate :uuid,                 :to => :unit, :prefix => true
  delegate :to_param,             :to => :unit
  delegate :number_of_recipients, :to => :unit
  delegate :coordinator_name,     :to => :unit
  delegate :coordinator_name=,    :to => :unit
  delegate :coordinator_email,    :to => :unit
  delegate :coordinator_email=,   :to => :unit
  delegate :meal_time,            :to => :unit
  delegate :meal_time=,           :to => :unit
  delegate :volunteer_pitch,      :to => :unit
  delegate :volunteer_pitch=,     :to => :unit
  delegate :reminder_subject,     :to => :unit
  delegate :reminder_subject=,    :to => :unit

  def initialize(unit)
    # Eager load the unit and its recipients.
    @unit = Unit.where(id: unit.try(:id)).
      includes(:recipients).
      first
  end

  def update(values, options = {})
    values.each do |k, v|
      send("#{k}=", v)
    end
    unit.recipients.each(&:save)
    unit.save
  end

  def recipients
    unit.recipients.to_a
  end

  def method_missing(method, *args)
    if /\Arecipient(?<num>\d+)_(?<meth>.+)\z/ =~ method.to_s
      unit.recipient_by_number(num).try(meth, *args)
    else
      super
    end
  end

end
