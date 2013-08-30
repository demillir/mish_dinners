$ ->
  $('h1 input[type="button"]').click ->
    window.location.href = $(this).parent().get(0).href
    false
