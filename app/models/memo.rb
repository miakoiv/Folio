class Memo < ApplicationRecord

  belongs_to :sender, class_name: 'User'
  has_many :deliveries, dependent: :destroy
  has_many :recipients, through: :deliveries,
    class_name: 'User', source: :user

  default_scope { order(created_at: :desc) }

  validates :title, :content, presence: true

  def to_s
    title
  end
end
