class Memo < ApplicationRecord

  belongs_to :sender, class_name: 'User'
  has_many :deliveries, dependent: :destroy

  default_scope { order(created_at: :desc) }

  validates :title, presence: true
  validates :recipient_ids, presence: true


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
    title
  end
end
