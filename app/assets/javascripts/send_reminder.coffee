$ ->
  $('.send-reminder-btn').click ->
    if confirm($(this).attr('data-confirm'))
      reminder_emailings_url = $(this).attr('data-url')
      uuid                   = $(this).attr('data-uuid')
      date                   = $(this).attr('data-date')
      $.post reminder_emailings_url, uuid: uuid, date: date
