module ImagesHelper

  def profile_image(imageable, options = {})
    options[:class] ||= ''
    options[:class] += ' img-circle'
    if imageable.respond_to?(:images) && imageable.images.any?
      image_tag imageable.images.first.attachment_url(:thumbnail), options
    end
  end
end
