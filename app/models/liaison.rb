class Liaison < ApplicationRecord

  belongs_to :unit
  belongs_to :person
  belongs_to :referrer
end
