$ ->
  for selection in $('.class-selection input:checked')
    $(selection).closest('section.appointment').attr('prev', selection.value)

  $('.class-selection input').change ->
    section = $(this).closest('section.appointment')
    oldClass = $(section).attr('prev')
    newClass = this.value
    $(section).attr('prev', newClass)
    $(section).removeClass(oldClass).addClass(newClass)
