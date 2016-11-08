$.fn.select2.defaults.set 'theme', 'bootstrap'

$.fn.select2.template = (option) ->
  label = $(option.element).data('label')
  if label?
    $('<span class="label label-' + label + '">' + option.text + '</span>')
  else
    option.text

$.fn.extend
  select2_handler: ->
    $(this)
      .find('[data-provide="select2"]')
      .not('.select2-hidden-accessible')
      .select2
        width: '100%'
        templateResult: $.fn.select2.template
        templateSelection: $.fn.select2.template

  select2_teardown: ->
    $(this)
      .find('[data-provide="select2"]')
      .select2 'destroy'

  select2_ajax_reset: (value) ->
    $field = $(this)
    $.ajax
      type: 'GET'
      url: $field.data 'ajax--url'
      data:
        q: value
      success: (data, status, xhr) ->
        $field.html '<option value=""></option>'
        first = data.results[0]
        if first?
          $option = $('<option>', {value: first.id, text: first.text, selected: true})
          $field.append($option)

$ ->
  $(document).select2_handler()
