$(document).on 'turbolinks:load', ->
  $('select.select2').each ->
    options = $(this).data()
    options['theme'] = 'bootstrap'
    $(this).select2 options
