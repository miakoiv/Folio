class Person < ApplicationRecord

  paginates_per 20

  belongs_to :postcode, optional: true
  belongs_to :municipality, optional: true

  default_scope { order(:last_name, :first_names) }

  validates :identification, presence: true
  validates :last_name, :first_names, presence: true

  def full_name
    return last_name if first_names.empty?
    [last_name, first_names].join ', '
  end

  def to_s
    full_name
  end
end
