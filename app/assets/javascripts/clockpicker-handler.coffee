$.fn.extend
  clockpicker_handler: ->
    $(this)
      .find('[data-provide="clockpicker"]')
      .clockpicker $(this).data

$ ->
  $(document).clockpicker_handler()

$(document).on 'shown.bs.modal', '.modal', ->
  $(this).clockpicker_handler()
