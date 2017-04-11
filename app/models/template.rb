class Template < ApplicationRecord
  belongs_to :unit

  enum purpose: [:generic, :header, :footer, :review]

  def to_s
    content.html_safe
  end
end
