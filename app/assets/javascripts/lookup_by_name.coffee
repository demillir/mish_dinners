$ ->
  # Hook up the pub-sub relationship between the lookup sources and their individual targets.
  for source in $('[data-lookup-source]')
    group = $(source).closest('[data-lookup-group]')
    target_ids = (target.id for target in group.find('[data-lookup-target]'))
    $(source).data('target_ids', target_ids)

  # Do the pub-sub thing when the user puts a value in the lookup source field.
  $('[data-lookup-source]').blur ->
    # Do nothing if there is no lookup text.
    return if !$(this).val()

    lookup_url = $(this).attr('data-url')
    uuid       = $(this).attr('data-uuid')
    name       = $(this).val()
    targets    = ($('#' + target_id) for target_id in $(this).data('target_ids'))
    $(this).addClass("wait")
    $.get lookup_url, uuid: uuid, name: name, (data) =>
      stuff_lookup_targets(targets, data.volunteers[0])
      $(this).removeClass("wait")


stuff_lookup_targets = (targets, volunteer_data) ->
  return unless volunteer_data?
  for target in targets
    key = target.attr('data-lookup-target')
    target.val(volunteer_data[key])
