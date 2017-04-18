class Diagnostic < ApplicationRecord
  has_many :consultations

  validates_presence_of :description
end
