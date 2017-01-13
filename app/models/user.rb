class User < ApplicationRecord

  # Adds `can_create?(resource)`, etc
  include Authority::UserAbilities

  # Adds `creatable_by?(user)`, etc
  include Authority::Abilities

  include Trackable
  rolify

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, and :omniauthable
  devise :database_authenticatable, :two_factor_authenticatable, :lockable,
         :recoverable, :rememberable, :trackable, :timeoutable, :validatable

  include Imageable

  # Two-factor authentication with OTPs
  has_one_time_password encrypted: true

  # The primary unit, users may have access to others, see Unit.accessible_by(user).
  belongs_to :unit

  # Customers where the user is the primary contact
  has_many :customers, foreign_key: :contact_id

  has_many :sent_memos, class_name: 'Memo', foreign_key: :sender_id
  has_many :deliveries, as: :recipient
  has_many :received_memos, through: :deliveries, source: :memo
  has_many :collections
  has_many :read_memos, through: :collections, source: :memo

  has_many :events, dependent: :destroy
  has_many :notes, dependent: :destroy

  default_scope { order(:last_name, :first_names) }

  scope :active, -> { where(
    (arel_table[:activates_at].eq(nil).or(arel_table[:activates_at].lteq(Date.current)))
    .and(arel_table[:expires_at].eq(nil).or(arel_table[:expires_at].gt(Date.current)))
  )}

  validates :last_name, :first_names, presence: true

  before_save :valid_two_factor_confirmation

  after_create :assign_default_role
  def assign_default_role
    add_role(:user, unit) if roles.blank?
  end

  def grantable_roles_at(unit)
    return [:user, :admin, :wizard] if has_role?(:wizard, unit)
    return [:user] if has_role?(:admin, unit)
    []
  end

  def active?
    (activates_at.nil? || !activates_at.future?) &&
    (expires_at.nil? || expires_at.future?)
  end

  # Overrides Devise method to ensure user is active.
  def active_for_authentication?
    super && active?
  end

  # 2FA is needed if enabled and already confirmed from an authorizer app.
  def need_two_factor_authentication?(request)
    two_factor_enabled? && !unconfirmed_two_factor?
  end

  def confirm_two_factor!(code)
    return false unless authenticate_otp(code)
    update(
      unconfirmed_two_factor: false,
      second_factor_attempts_count: 0
    )
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

  private
    def generate_secret_key
      self.otp_secret_key = generate_totp_secret
    end

    # If two-factor authentication has just been enabled, set status to
    # unconfirmed and generate a fresh secret key.
    def valid_two_factor_confirmation
      if two_factor_just_set
        self.unconfirmed_two_factor = true
        generate_secret_key
      else
        self.unconfirmed_two_factor = false
      end
      true
    end

    def two_factor_just_set
      two_factor_enabled? && two_factor_enabled_changed?
    end
end
