class Unit
  def coordinator_email
    'LOmissionarymeals@gmail.com'
  end

  def meal_time
    '6pm for dinner in your home, 3-6pm for sack dinners.'
  end

  def volunteer_pitch
    <<-EOS
      Please sign up to provide dinner for the missionaries serving in the Lake Oswego Ward.
      You can sign up for one or both companionships on the same evening.
      Include your email address to receive a reminder email two days before the dinner appointment.
      If a dinner slot has a "SACK" watermark, the meal should be a sack dinner delivered to the
      Portland Temple Visitors' Center.
    EOS
  end

  def appointment_data_for_date_and_recipient_number(date, recipient_number)
    {
      name:      'Leuenberger',
      phone:     '503-999-0000',
      email:     'foo@bar.com',
      css_class: ['sack', nil].sample,
    }
  end

  def number_of_recipients
    2
  end

  def recipient_data_for_recipient_number(recipient_number)
    %w( 503-490-3314 503-608-8858 ).map { |ph| {phone: ph} }[recipient_number-1].merge(number: recipient_number)
  end
end
