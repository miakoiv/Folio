class DocumentUploader < Shrine
  plugin :remote_url, max_size: 16_777_216
  plugin :validation_helpers, default_messages: {
    mime_type_inclusion: -> (list) {
      I18n.t('errors.messages.mime_type_inclusion', list: list.join(', '))
    }
  }

  Attacher.validate do
    validate_mime_type_inclusion %w{application/pdf}
  end
end
