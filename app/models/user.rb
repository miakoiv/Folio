class User < ApplicationRecord

  # Adds `can_create?(resource)`, etc
  include Authority::UserAbilities

  # Adds `creatable_by?(user)`, etc
  include Authority::Abilities

  rolify

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, and :omniauthable
  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :trackable, :timeoutable, :validatable

  include Imageable

  # The primary unit, users may have access to others, see Unit.accessible_by(user).
  belongs_to :unit

  has_many :sent_memos, class_name: 'Memo', foreign_key: :sender_id
  has_many :deliveries, as: :recipient
  has_many :received_memos, through: :deliveries, source: :memo

  has_many :events, dependent: :destroy
  has_many :notes, dependent: :destroy

  default_scope { order(:last_name, :first_names) }

  scope :active, -> { where(
    (arel_table[:activates_at].eq(nil).or(arel_table[:activates_at].lteq(Date.current)))
    .and(arel_table[:expires_at].eq(nil).or(arel_table[:expires_at].gt(Date.current)))
  )}

  validates :last_name, :first_names, presence: true

  after_create :assign_default_role
  def assign_default_role
    add_role(:user, unit) if roles.blank?
  end

  def grantable_roles_at(unit)
    has_role?(:admin, unit) && [:user] || []
  end

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
