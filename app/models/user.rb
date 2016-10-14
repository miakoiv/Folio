class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, and :omniauthable
  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :trackable, :timeoutable, :validatable

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
end
