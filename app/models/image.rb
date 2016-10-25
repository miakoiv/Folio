class Image < ApplicationRecord
  include AttachmentUploader[:attachment]

  belongs_to :imageable, polymorphic: true
end
