class Document < ApplicationRecord
  include DocumentUploader[:attachment]

  belongs_to :documentable, polymorphic: true
end
