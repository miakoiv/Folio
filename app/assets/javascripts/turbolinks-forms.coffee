@formBindings = ->
  $('[data-behavior="turbolinks"]')
    .on 'ajax:error', (e, xhr, status, error) ->
      $(this).replaceWith xhr.responseText

$(document).on 'turbolinks:load', @formBindings
