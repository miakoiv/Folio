require 'image_processing/mini_magick'

class DocumentUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :remote_url, max_size: 16_777_216
  plugin :processing
  plugin :versions
  plugin :parallelize, threads: 4
  plugin :validation_helpers, default_messages: {
    mime_type_inclusion: -> (list) {
      I18n.t('errors.messages.mime_type_inclusion', list: list.join(', '))
    }
  }

  Attacher.validate do
    validate_mime_type_inclusion %w{application/pdf}
  end

  process(:store) do |io, context|
    original = with_minimagick(io.download) do |image|
      image.format :png
      image.colorspace :sRGB
    end
    thumbnail = resize_to_limit(original,  80,  80)
    icon      = resize_to_fill(thumbnail,  40,  40)

    {
      original:  io,
      thumbnail: thumbnail,
      icon:      icon
    }
  end
end
