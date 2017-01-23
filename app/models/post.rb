class Post < ApplicationRecord

  include Trackable

  paginates_per 10

  belongs_to :unit
  belongs_to :author, class_name: 'User'


  default_scope { order(created_at: :desc) }
  scope :by, -> (author) { where(author: author) }

  validates :title, presence: true

  def fresh?
    created_at > 2.hours.ago
  end

  def to_s
    title
  end
end
