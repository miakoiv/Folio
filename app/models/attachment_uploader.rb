class AttachmentUploader < Shrine
  plugin :remote_url, max_size: 16_777_216
end
