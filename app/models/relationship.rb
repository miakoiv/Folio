class Relationship < ApplicationRecord

  # Person is related to parent in a relation way.
  belongs_to :person
  belongs_to :parent, class_name: 'Person'
  belongs_to :relation

end
