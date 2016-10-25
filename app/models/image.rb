class Image < ApplicationRecord
  include ImageUploader[:attachment]

  belongs_to :imageable, polymorphic: true
end
