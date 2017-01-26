module ImagesHelper

  def profile_image(imageable, options = {})
    classes = (options[:class] || '').split
    classes << 'img-circle grayscale'
    options[:class] = classes.join(' ')
    if imageable.respond_to?(:images) && imageable.images.any?
      first = imageable.images.first
      image_tag first.attachment_url(:thumbnail), options
    end
  end
end
