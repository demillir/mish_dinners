module CalendarHelper
  def fixed_size(text, truncate_at)
    text_str = text.to_s
    return text_str if text_str.length <= truncate_at

    content_tag(:abbr, title: text_str) do
      text_str.truncate(truncate_at)
    end
  end

  def edit_form_buttons(calendar)
    content_tag(:div, class: 'buttons') do
      submit_tag("Save changes", class: "save_btn") +
      link_to('Cancel', url_for("/#{calendar.division_abbr}/#{calendar.unit_abbr}?print"), class: "cancel_btn")
    end
  end

  def calendar_range(calendar)
    if calendar.start_date.at_beginning_of_month == calendar.end_date.at_beginning_of_month
      calendar.start_date.at_beginning_of_month.strftime('%B %Y')
    elsif calendar.start_date.year == calendar.end_date.year
      "#{calendar.start_date.strftime('%b')}-#{calendar.end_date.strftime('%b %Y')}"
    else
      "#{calendar.start_date.strftime('%b %Y')} - #{calendar.end_date.strftime('%b %Y')}"
    end
  end

  def adjacent_calendar_path(calendar, multiplier)
    days_in_calendar = calendar.end_date - calendar.start_date + 1
    new_calendar_start_date = calendar.start_date + (multiplier * days_in_calendar)

    uri = URI(request.original_url)
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
end
