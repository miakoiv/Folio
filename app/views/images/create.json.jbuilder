json.partial! 'images/image', image: @image
json.image_path image_path(@image, format: :js)
