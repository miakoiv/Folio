class Note < ApplicationRecord

  include Trackable

  belongs_to :user
  belongs_to :customer, optional: true
  after_create :touch_customer

  default_scope { order(created_at: :desc) }
  scope :by, -> (user) { where(user: user) }

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
