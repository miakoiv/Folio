window.toastr.options =
  debug: false
  newestOnTop: false
  positionClass: 'toast-top-center'
  closeButton: true
  toastClass: 'animated fadeInDown'

@toastrTypes =
  notice: 'info'
  alert: 'warning'
  error: 'danger'

@toastrHandler = (e, params) ->
  toastr[@toastrTypes[params.type]](params.message)

$(window).on 'rails:flash', @toastrHandler
