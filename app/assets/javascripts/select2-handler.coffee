$.fn.select2.defaults.set 'theme', 'bootstrap'

$.fn.select2.template = (option) ->
  label = $(option.element).data('label')
  if label?
    $('<span class="label label-' + label + '">' + option.text + '</span>')
  else
    option.text

$ ->
  $(document)
    .find('[data-provide="select2"]')
    .not('.select2-hidden-accessible')
    .select2
      templateResult: $.fn.select2.template
      templateSelection: $.fn.select2.template
