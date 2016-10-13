class User < ApplicationRecord

  validates :email, :last_name, :first_names,
    presence: true

  def full_name
    return last_name if first_names.empty?
    [last_name, first_names].join ', '
  end
end
