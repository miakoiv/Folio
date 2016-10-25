require 'image_processing/mini_magick'

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :remote_url, max_size: 16_777_216
  plugin :processing
  plugin :versions

  process(:store) do |io, context|
    lightbox  = resize_to_limit(io.download, 720, 720)
    preview   = resize_to_limit(lightbox,    160, 160)
    thumbnail = resize_to_fill(lightbox,      80,  80)
    icon      = resize_to_fill(thumbnail,     40,  40)

    {
      original:  io,
      lightbox:  lightbox,
      preview:   preview,
      thumbnail: thumbnail,
      icon:      icon
    }
  end
end
