module CalendarHelper
  def fixed_size(text, truncate_at)
    text_str = text.to_s
    text_str.truncate(truncate_at)
  end
end
