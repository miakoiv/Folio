$.fn.extend
  autofocus: ->
    $(this).find('[autofocus]').focus()

$(document).on 'shown.bs.modal', '.modal', ->
  $(this).autofocus()

$ ->
  $(document).autofocus()
