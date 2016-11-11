class Person < ApplicationRecord

  include Imageable

  paginates_per 20

  belongs_to :creator, class_name: 'User'
  has_many :liaisons, dependent: :destroy

  belongs_to :postcode, optional: true
  belongs_to :municipality, optional: true
  belongs_to :education_level, optional: true

  # Relationships with parents, guardians, or other benefactors called
  # collectively as "parents".
  has_many :relationships, dependent: :destroy
  has_many :parents, through: :relationships, source: :parent

  # Parentships are relationships where this person is the parent.
  # Caching the number of parentships as children count gives us
  # a scope for "parental units".
  has_many :parentships, class_name: 'Relationship', foreign_key: :parent_id,
    counter_cache: :children_count
  attr_readonly :children_count
  scope :parental, -> { where(arel_table[:children_count].gt(0)) }

  def parental?
    children_count > 0
  end

  # People who are not parents are potential customers.
  scope :customer, -> { where(children_count: 0) }

  def customer?
    children_count == 0
  end

  default_scope { order(:last_name, :first_names) }


  validates :last_name, :first_names, presence: true

  def self.assigned_municipalities
    ids = unscope(:order).pluck(:municipality_id).reject(&:blank?).uniq
    ids.any? ? Municipality.find(ids) : Municipality.none
  end

  def self.assigned_postcodes
    ids = unscope(:order).pluck(:postcode_id).reject(&:blank?).uniq
    ids.any? ? Postcode.find(ids) : Postcode.none
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
