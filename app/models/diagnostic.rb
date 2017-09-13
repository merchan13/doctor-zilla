class Diagnostic < ApplicationRecord
  has_many :consultation_diagnostics
  has_many :consultations, through: :consultation_diagnostics

  validates_presence_of :description
  validates :description, uniqueness: { case_sensitive: false }
end
