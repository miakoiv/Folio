class Person < ApplicationRecord

  include Imageable
  include Trackable

  paginates_per 20

  has_many :customers, dependent: :destroy

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

  default_scope { order(:last_name, :first_names) }


  validates :last_name, :first_names, presence: true

  before_destroy :scrub_activity!


  def self.assigned_municipalities
    ids = unscope(:order).pluck(:municipality_id).reject(&:blank?).uniq
    ids.any? ? Municipality.find(ids) : Municipality.none
  end

  def self.assigned_postcodes
    ids = unscope(:order).pluck(:postcode_id).reject(&:blank?).uniq
    ids.any? ? Postcode.find(ids) : Postcode.none
  end

  # Customers have a newest first default scope.
  def current_customer(unit)
    customers.at(unit).first
  end

  def status(unit)
    current_customer(unit).try(:status)
  end

  def expired?
    updated_at < 1.year.ago
  end

  def appearance(unit)
    return 'expired' if expired?
    current_customer(unit).try(:appearance) || 'default'
  end

  def full_name
    return last_name unless first_names.present?
    [last_name, first_names].join ', '
  end

  def education_to_s
    return nil unless education_level.present?
    education_level.needs_info? ? education_info : education_level.to_s
  end

  # Text method for JSON responses to select2
  def text
    to_s
  end

  def to_s
    full_name
  end

  private
    # Before deleting a person, their activity records are scrubbed
    # to erase any personally identifiable information.
    def scrub_activity!
      activities.each do |activity|
        activity.scrub!
      end
    end
end

require_dependency 'person/stats'
