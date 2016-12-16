# Opposite of delivery: a user collects a memo when she reads it.

class Collection < ApplicationRecord
  belongs_to :memo
  belongs_to :user

  scope :by, -> (user) { where(user: user) }
end
