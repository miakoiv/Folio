class Template < ApplicationRecord
  belongs_to :unit

  enum purpose: [:generic, :header, :footer, :review]
end
