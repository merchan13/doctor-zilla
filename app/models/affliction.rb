class Affliction < ApplicationRecord
  has_many :consultation_afflictions
  has_many :consultations, through: :consultation_afflictions
end
