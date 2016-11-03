class Memo < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :unit

  has_and_belongs_to_many :recipients, class_name: 'User'

  default_scope { order(created_at: :desc) }

  validates :title, :content, presence: true

  def to_s
    title
  end
end
