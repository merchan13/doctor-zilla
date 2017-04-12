class Consultation < ApplicationRecord
  belongs_to :medical_record

  has_many :notes
  has_many :evolutions
  has_many :basic_exams
  # Motivos de consulta
  has_many :consultation_reasons
  has_many :reasons, through: :consultation_reasons
  # Enfermedad actual
  has_many :consultation_afflictions
  has_many :afflictions, through: :consultation_afflictions
  # Examen fisico
  has_many :consultation_physical_exams
  has_many :physical_exams, through: :consultation_physical_exams
end
