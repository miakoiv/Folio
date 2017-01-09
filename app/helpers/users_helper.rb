module UsersHelper
  def two_factor_options
    [
      [icon('unlock'), false],
      [icon('lock'),   true]
    ]
  end

  def google_authenticator_qrcode(user)
    qrcode = RQRCode::QRCode.new(user.provisioning_uri)
    base64 = Base64.encode64(qrcode.as_svg(module_size: 16))
    image_tag "data:image/svg+xml;base64,#{base64}", class: 'img-responsive'
  end
end
