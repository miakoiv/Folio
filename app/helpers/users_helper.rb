module UsersHelper

  def profile_image(user)
    image_tag '//gravatar.com/avatar/' + Digest::MD5.hexdigest(user.email),
        class: 'img-circle m-b'
  end
end
