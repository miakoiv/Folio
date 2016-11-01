class Note < ApplicationRecord
  belongs_to :liaison
  belongs_to :creator
end
