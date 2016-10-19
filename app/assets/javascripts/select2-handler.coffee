@bindSelect2 = ->
  $(document)
    .find('[data-provide="select2"]')
    .not('.select2-hidden-accessible')
    .select2()

$ ->
  bindSelect2()
