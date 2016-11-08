class Relationship < ApplicationRecord

  # Person is related to parent in a relation way.
  belongs_to :relation
  belongs_to :person
  belongs_to :parent, class_name: 'Person'
  accepts_nested_attributes_for :parent

end
