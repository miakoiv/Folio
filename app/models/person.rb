class Person < ApplicationRecord

  include Imageable

  paginates_per 20

  has_many :liaisons, dependent: :destroy

  belongs_to :postcode, optional: true
  belongs_to :municipality, optional: true
  belongs_to :education_level, optional: true

  default_scope { order(:last_name, :first_names) }

  validates :identification, presence: true
  validates :last_name, :first_names, presence: true

  def self.assigned_municipalities
    ids = unscope(:order).pluck(:municipality_id).uniq
    Municipality.find(ids)
  end

  def full_name
    return last_name if first_names.empty?
    [last_name, first_names].join ', '
  end

  def to_s
    full_name
  end
end
