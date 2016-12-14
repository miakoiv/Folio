class Memo < ApplicationRecord

  belongs_to :sender, class_name: 'User'
  has_many :deliveries

  default_scope { order(created_at: :desc) }

  validates :title, presence: true

  def to_s
    title
  end
end
