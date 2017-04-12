class Note < ApplicationRecord
  belongs_to :consultation

  validates_presence_of :description
end
