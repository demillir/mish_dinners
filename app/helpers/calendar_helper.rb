module CalendarHelper
  def fixed_size(text, truncate_at)
    text_str = text.to_s
    return text_str if text_str.length <= truncate_at

    content_tag(:abbr, title: text_str) do
      text_str.truncate(truncate_at)
    end
  end

  def calendar_range(calendar, page_offset=0)
    weeks_offset = page_offset * calendar.num_weeks_to_display
    days_offset  = weeks_offset * 7
    start_date   = calendar.start_date + days_offset
    end_date     = calendar.end_date + days_offset

    if start_date.at_beginning_of_month == end_date.at_beginning_of_month
      start_date.at_beginning_of_month.strftime('%B %Y')
    elsif start_date.year == end_date.year
      "#{start_date.strftime('%b')}-#{end_date.strftime('%b %Y')}"
    else
      "#{start_date.strftime('%b %Y')} - #{end_date.strftime('%b %Y')}"
    end
  end

  def adjacent_calendar_link(calendar, multiplier, form=nil)
    left_or_right = multiplier < 0 ? 'left' : 'right'
    if form
      submit_tag(left_or_right == 'left' ? "<=" : "=>") +
        hidden_field(:adjacent, left_or_right, value: adjacent_start_date(calendar, multiplier))
    else
      link_to adjacent_calendar_path(calendar, multiplier), class: "#{left_or_right} screen-only" do
        button_tag raw("&#{left_or_right[0]}Arr;"), type: "button"
      end
    end
  end

  private

  def adjacent_calendar_path(calendar, multiplier)
    new_calendar_start_date = adjacent_start_date(calendar, multiplier)

    uri = URI(request.original_fullpath)
    date_query = {date: new_calendar_start_date}.to_query
    if uri.query.blank?
      uri.query = date_query
    elsif (old_date_query = uri.query.split('&').grep(/\Adate=\d/).first)
      uri.query = uri.query.split(old_date_query, -1).join(date_query)
    else
      uri.query = [uri.query, date_query].join('&')
    end
    uri.to_s
  end

  def adjacent_start_date(calendar, multiplier)
    days_in_calendar = calendar.end_date - calendar.start_date + 1
    calendar.start_date + (multiplier * days_in_calendar)
  end
end
