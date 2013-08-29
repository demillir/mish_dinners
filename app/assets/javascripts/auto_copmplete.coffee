$ ->
  for field in $('section.appointment input[type="text"], section.appointment input[type="email"]')
    $(field).autocomplete(
      source: window[$(field).attr('data-autocomplete-source')],
      messages:
        noResults: '',
        results: ->
          ''
    )
