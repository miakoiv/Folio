class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, and :omniauthable
  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :trackable, :timeoutable, :validatable

  include Imageable

  belongs_to :unit

  has_many :sent_memos, class_name: 'Memo', foreign_key: :sender_id
  has_many :deliveries, as: :recipient
  has_many :received_memos, through: :deliveries, source: :memo

  has_many :liaisons
  has_many :events, through: :liaisons

  default_scope { order(:last_name, :first_names) }

  scope :active, -> { where %q{
    (users.activates_at IS NULL OR users.activates_at >= :today) AND
    (users.expires_at IS NULL OR users.expires_at > :today)
  }, today: Date.current}

  validates :last_name, :first_names, presence: true

  def active?
    (activates_at.nil? || !activates_at.future?) &&
    (expires_at.nil? || expires_at.future?)
  end

  # Overrides Devise method to ensure user is active.
  def active_for_authentication?
    super && active?
  end

  def full_name
    return last_name if first_names.empty?
    [last_name, first_names].join ', '
  end


  def self.to_collection_title
    model_name.human(count: 2).capitalize
  end

  def to_s
    full_name
  end
end
