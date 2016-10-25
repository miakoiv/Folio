module ImagesHelper

  def profile_image(imageable, options = {})
    options.reverse_merge!(
      class: 'img-circle',
      style: 'max-width: 80px; height: auto;'
    )
    if imageable.images.any?
      image_tag imageable.images.first.attachment_url, options
    end
  end
end
