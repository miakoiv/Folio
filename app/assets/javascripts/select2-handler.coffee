$.fn.select2.defaults.set 'theme', 'bootstrap'

$ ->
  $(document)
    .find('[data-provide="select2"]')
    .not('.select2-hidden-accessible')
    .select2()
