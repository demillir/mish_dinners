$ ->
  # On page load, memoize the checked radio button value into the 'curr_selection' attribute.
  for selection in $('.class-selection input:checked')
    $(selection).closest('section.appointment').attr('curr_selection', selection.value)

  $('.class-selection input').change ->
    element_to_change = $(this).closest('section.appointment')

    class_to_remove = $(element_to_change).attr('curr_selection')
    class_to_add = this.value
    $(element_to_change).removeClass(class_to_remove).addClass(class_to_add)

    # Re-memoize the checked radio button.
    $(element_to_change).attr('curr_selection', class_to_add)
