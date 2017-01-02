module ImagesHelper

  def profile_image(imageable, options = {})
    options[:class] ||= ''
    options[:class] += ' img-circle'
    if imageable.respond_to?(:images) && imageable.images.any?
      first = imageable.images.first
      image_tag first.attachment_url(:thumbnail),
        options.merge('data-printable': first.attachment_url(:preview))
    end
  end
end
