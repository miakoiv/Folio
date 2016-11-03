class Delivery < ApplicationRecord

  belongs_to :memo
  belongs_to :user

  def unread?
    !read?
  end
end
