module ImagesHelper

  def profile_image(imageable, options = {})
    options.reverse_merge!(class: 'img-circle')
    if imageable.images.any?
      image_tag imageable.images.first.attachment_url(:thumbnail), options
    end
  end
end
