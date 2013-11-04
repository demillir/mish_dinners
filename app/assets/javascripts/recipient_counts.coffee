$ ->
  $('.recipient_count_radio_btn').change ->
    for recipient_fields in $(this).closest('fieldset').find('[data-recipient-number]')
      if $(recipient_fields).attr('data-recipient-number') > this.value
        $(recipient_fields).hide()
      else
        $(recipient_fields).show()

    if this.value < $(this).attr('data-orig-count')
      # Warn the user about potential data loss
      alert("Reducing the number will delete the schedule for each discarded " + $(this).attr('data-recipient-title') + ".  If you don't want to lose the schedule, change the number back.")
