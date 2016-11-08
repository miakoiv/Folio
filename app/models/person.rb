class Person < ApplicationRecord

  include Imageable

  paginates_per 20

  belongs_to :creator, class_name: 'User'
  has_many :liaisons, dependent: :destroy

  belongs_to :postcode, optional: true
  belongs_to :municipality, optional: true
  belongs_to :education_level, optional: true

  # Relationships with parents, guardians, or other benefactors called
  # collectively as "parents". The other party subsequently has "children".
  has_many :relationships, dependent: :destroy
  has_many :parents, through: :relationships, source: :parent
  has_many :parentships, class_name: 'Relationship', foreign_key: :parent_id

  default_scope { order(:last_name, :first_names) }

  validates :last_name, :first_names, presence: true

  def self.assigned_municipalities
    ids = unscope(:order).pluck(:municipality_id).uniq
    ids.any? ? Municipality.find(ids) : Municipality.none
  end

  # Liaisons have a newest first default scope.
  def current_liaison(unit)
    liaisons.at(unit).first
  end

  def assigned_user(unit)
    current_liaison(unit).try(:user)
  end

  def status(unit)
    current_liaison(unit).try(:status)
  end

  def appearance(unit)
    current_liaison(unit).try(:appearance) || 'default'
  end

  def full_name
    return last_name unless first_names.present?
    [last_name, first_names].join ', '
  end

  # Text method for JSON responses to select2
  def text
    to_s
  end

  def to_s
    full_name
  end
end
