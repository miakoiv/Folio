window.toastr.options =
  debug: false
  newestOnTop: false
  closeButton: true
  toastClass: 'animated fadeInDown'

window.UnobtrusiveFlash.mapping =
  notice: 'info'
  alert: 'warning'
  error: 'danger'

UnobtrusiveFlash.showFlashMessage = (message, type) ->
  toastr[UnobtrusiveFlash.mapping[type]](message)

@toastrHandler = (e, params) ->
  UnobtrusiveFlash.showFlashMessage params.message, params.type

$(window).on 'rails:flash', @toastrHandler
