class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :registerable, :confirmable, and :omniauthable
  devise :database_authenticatable, :lockable, :recoverable,
         :rememberable, :trackable, :timeoutable, :validatable

  validates :last_name, :first_names, presence: true

  def full_name
    return last_name if first_names.empty?
    [last_name, first_names].join ', '
  end
end
