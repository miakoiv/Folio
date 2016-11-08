class Note < ApplicationRecord

  belongs_to :creator, class_name: 'User'
  belongs_to :liaison
  after_create :touch_liaison

  default_scope { order(created_at: :desc) }

  validates :title, :content, presence: true

  def fresh?
    created_at > 2.hours.ago
  end

  def to_s
    title
  end

  private
    def touch_liaison
      liaison.touch
    end
end
