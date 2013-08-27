module NormalizesPhone
  extend ActiveSupport::Concern

  # Normalize phone numbers to "DDD-DDD-DDDD"
  def phone=(val)
    normalized_phone = val.to_s.gsub(/\D/, '')
    if normalized_phone.length == 10
      normalized_phone = "#{normalized_phone[0, 3]}-#{normalized_phone[3, 3]}-#{normalized_phone[6, 4]}"
      super normalized_phone
    else
      super
    end
  end
end
