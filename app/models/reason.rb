class Reason < ApplicationRecord
  has_many :consultation_reasons
  has_many :consultations, through: :consultation_reasons

  validates_presence_of :description
end
