$ ->
  $('.send-reminder-btn').click ->
    if confirm($(this).attr('data-confirm'))
      uuid = $(this).attr('data-uuid')
      date = $(this).attr('data-date')
      post_params = [
        {name: 'uuid', value: uuid},
        {name: 'date', value: date}
      ]

      # Combine the uuid and data from above with the name/value pairs of all the form input elements
      # in this button's day.  The result will be a query params string that looks like:
      #   uuid=1bd97844-2bb1-4046-bbe8-d63f6411af46&
      #     date=2013-10-24&
      #     calendar%5B2013-10-24%5D%5B1%5D%5Bname%5D=Millironx&
      #     calendar%5B2013-10-24%5D%5B1%5D%5Bphone%5D=&
      #     calendar%5B2013-10-24%5D%5B1%5D%5Bemail%5D=danmx%40foo.com&
      #     ...
      query_params = $.param(post_params) + '&' + $(this).closest('td.day').find('input').serialize()

      reminder_emailings_url = $(this).attr('data-url')
      $.post reminder_emailings_url
        , query_params
        , (data) ->
          alert data['info']
