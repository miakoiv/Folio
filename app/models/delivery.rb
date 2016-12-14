class Delivery < ApplicationRecord
  belongs_to :memo
  belongs_to :recipient, polymorphic: true
end
