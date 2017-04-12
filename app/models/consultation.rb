class Consultation < ApplicationRecord
  belongs_to :medical_record

  has_many :notes
  has_many :evolutions
  has_many :basic_exams
  has_many :consultation_reasons
  has_many :reasons, through: :consultation_reasons
end
