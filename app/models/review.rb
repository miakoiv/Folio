class Review < ApplicationRecord

  # Adds `creatable_by?(user)`, etc
  include Authority::Abilities

  include Trackable

  belongs_to :user
  belongs_to :customer
  after_create :touch_customer

  default_scope { order(created_at: :desc) }
  scope :by, -> (user) { where(user: user) }
  scope :published, -> { where(
    arel_table[:published_at].lteq(Date.current)
  )}

  validates :title, presence: true

  def published?
    published_at.present? && !published_at.future?
  end

  def to_s
    title
  end

  private
    def touch_customer
      customer.touch
    end
end
