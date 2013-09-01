$ ->
  for field in $('[data-autocomplete-source]')
    $(field).autocomplete(
      source: window[$(field).attr('data-autocomplete-source')],
      messages:
        noResults: '',
        results: ->
          ''
    )
