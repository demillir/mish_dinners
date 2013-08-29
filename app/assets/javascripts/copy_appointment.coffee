$ ->
  $('.copy-appointment-btn').click ->
    day = $(this).closest('td.day')
    src  = day.find('section.appointment:first').first()[0]
    for dst in day.find('section.appointment:not(:first)')
      copy_appointment(src, dst)

copy_appointment = (src, dst) ->
  values = (field.value for field in $(src).find('input[type="text"], input[type="email"]'))
  for field, i in $(dst).find('input[type="text"], input[type="email"]')
    field.value = values[i]
