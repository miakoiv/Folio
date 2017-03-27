class Relationship < ApplicationRecord

  include Trackable

  # Person is related to parent in a relation way. Parents keep a cached
  # children count to immediately identify people who are parents and
  # exclude them from the index view.
  belongs_to :relation
  belongs_to :person
  belongs_to :parent, class_name: 'Person', counter_cache: :children_count
  accepts_nested_attributes_for :parent


  def appearance
    legal_guardian? ? 'primary' : 'default'
  end
end
