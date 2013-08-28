module CalendarHelper
  def fixed_size(text, truncate_at)
    text_str = text.to_s
    return text_str if text_str.length <= truncate_at

    content_tag(:abbr, title: text_str) do
      text_str.truncate(truncate_at)
    end
  end
end
