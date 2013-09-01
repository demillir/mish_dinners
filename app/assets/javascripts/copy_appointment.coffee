$ ->
  $('.copy-appointment-btn').click ->
    day_element = $(this).closest('td.day')
    src_appointment_element  = day_element.find('section.appointment:first').get(0)
    for dst_appointment_element in day_element.find('section.appointment:not(:first)')
      copy_appointment(src_appointment_element, dst_appointment_element)

copy_appointment = (src_elem, dst_elem) ->
  values = (field.value for field in $(src_elem).find('input.copyable'))
  for field, i in $(dst_elem).find('input.copyable')
    field.value = values[i]
