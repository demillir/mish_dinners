$ ->
  for field in $('section.appointment input[type=text]')
    $(field).autocomplete(
      source: window[$(field).attr('data-autocomplete-source')],
      messages:
        noResults: '',
        results: ->
          ''
    )
