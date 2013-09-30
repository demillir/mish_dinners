$ ->
  $('body').on 'keydown', 'input', 'select', (e) ->
    if e.keyCode == 13
      form = $(this).parents('form:eq(0)')
      focusable = form.find('input,a,select,button,textarea')
      next = focusable.eq(focusable.index(this)+1)
      next.focus() if next.length
      false
