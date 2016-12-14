$ ->
  $(document).on 'click', '[data-href]', (e) ->
    e.preventDefault()
    window.location = $(this).data 'href'
