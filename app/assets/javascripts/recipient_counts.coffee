$ ->
  $('.recipient_count_radio_btn').change ->
    for phone_fields in $(this).closest('fieldset').find('[data-recipient-number]')
      if $(phone_fields).attr('data-recipient-number') > this.value
        $(phone_fields).hide()
      else
        $(phone_fields).show()

    if this.value < $(this).attr('data-orig-count')
      alert("Reducing the number will remove the schedule for each discarded " + $(this).attr('data-recipient-title') + ".  If you don't want to lose the schedule, change the number back.")
