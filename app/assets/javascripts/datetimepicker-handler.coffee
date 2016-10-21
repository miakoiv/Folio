$.fn.datetimepicker.defaults.format = 'YYYY-MM-DD'
$.fn.datetimepicker.defaults.useCurrent = true
$.fn.datetimepicker.defaults.showTodayButton = true
$.fn.datetimepicker.defaults.icons =
  time: 'fa fa-clock-o'
  date: 'fa fa-calendar'
  up: 'fa fa-plus-circle fa-lg'
  down: 'fa fa-minus-circle fa-lg'
  previous: 'fa fa-arrow-circle-left'
  next: 'fa fa-arrow-circle-right'
  today: 'fa fa-map-marker fa-lg'
  clear: 'fa fa-eraser fa-lg'

$ ->
  $('[data-provide="datetimepicker"]')
    .datetimepicker()
