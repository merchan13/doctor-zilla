class Background < ApplicationRecord
  has_many :consultation_backgrounds
  has_many :consultations, through: :consultation_backgrounds

  validates_presence_of :background_type, :description
end
