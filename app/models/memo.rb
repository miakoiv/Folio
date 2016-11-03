class Memo < ApplicationRecord

  belongs_to :sender, class_name: 'User'
  has_and_belongs_to_many :recipients, class_name: 'User'

  default_scope { order(created_at: :desc) }

  validates :title, :content, presence: true

  def to_s
    title
  end
end
