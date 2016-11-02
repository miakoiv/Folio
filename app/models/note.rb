class Note < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :liaison

  default_scope { order(created_at: :desc) }

  validates :title, :content, presence: true

  def to_s
    title
  end
end
