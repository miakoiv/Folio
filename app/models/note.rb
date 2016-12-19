class Note < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :customer
  after_create :touch_customer

  default_scope { order(created_at: :desc) }

  validates :title, :content, presence: true

  def fresh?
    created_at > 2.hours.ago
  end

  def to_s
    title
  end

  private
    def touch_customer
      customer.touch
    end
end
