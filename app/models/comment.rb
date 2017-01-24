class Comment < ApplicationRecord

  include Trackable

  belongs_to :post
  belongs_to :author, class_name: 'User'

  default_scope { order(created_at: :asc) }
  scope :by, -> (author) { where(author: author) }

  validates :content, presence: true
end
