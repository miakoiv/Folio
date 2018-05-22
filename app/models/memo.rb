class Memo < ApplicationRecord

  include Trackable

  belongs_to :sender, -> { merge(User.including_deleted) }, class_name: 'User'
  has_many :deliveries, dependent: :destroy
  has_many :collections, dependent: :destroy

  default_scope { order(created_at: :desc) }

  validates :title, presence: true
  validates :recipient_ids, presence: true


  def collected_by?(user)
    collections.by(user).first
  end

  def collect_by(user)
    collections.by(user).first_or_create
  end

  # Delivery recipients as a list of global ids.
  def recipient_ids
    deliveries.map { |d| d.recipient.to_global_id }
  end

  # Builds deliveries through a list of recipient global ids.
  def recipient_ids=(list)
    list.reject(&:blank?).map do |gid|
      deliveries.build(recipient: GlobalID::Locator.locate(gid))
    end
  end

  def to_s
    "#{Memo.model_name.human.capitalize} #{created_at.year}-#{id}"
  end
end
