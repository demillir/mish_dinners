AttributeNormalizer.configure do |config|

  config.normalizers[:dashed_phone] = lambda do |value, options|
    if value.is_a?(String)
      normalized_phone = value.gsub(/\D/, '')
      if normalized_phone.length == 10
        "#{normalized_phone[0, 3]}-#{normalized_phone[3, 3]}-#{normalized_phone[6, 4]}"
      elsif value.empty?
        nil
      else
        value
      end
    else
      value
    end
  end

  # The default normalizers if no :with option or block is given is to apply the :strip and :blank normalizers (in that order).
  # You can change this if you would like as follows:
  config.default_normalizers = :squish, :blank

  # You can enable the attribute normalizers automatically if the specified attributes exist in your column_names. It will use
  # the default normalizers for each attribute (e.g. config.default_normalizers)
  config.default_attributes = :name, :email

  # Also, You can add an specific attribute to default_attributes using one or more normalizers:
  # config.add_default_attribute :phone, :with => :dashed_phone
end
