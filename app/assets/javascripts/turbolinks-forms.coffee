@formBindings = ->
  $('[data-behavior="turbolinks"]')
    .on 'ajax:success', (e, data, status, xhr) ->
      Turbolinks.clearCache()
    .on 'ajax:error', (e, xhr, status, error) ->
      $(this).replaceWith xhr.responseText

$(document).on 'turbolinks:load', @formBindings
