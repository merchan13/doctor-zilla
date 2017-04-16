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
  # Diagnóstico
  has_many :consultation_diagnostics
  has_many :diagnostics, through: :consultation_diagnostics
  # Antecedentes
  has_many :consultation_backgrounds
  has_many :backgrounds, through: :consultation_backgrounds

  def add_reason(reason)
    self.reasons << Reason.find(reason)
  end

  def add_affliction(affliction)
    # ...
  end

  def add_physical_exam(physical_exam)
    # ...
  end

  def add_diagnostic(diagnostic)
    # ...
  end

  def add_basic_exam(basic_exam)
    # ...
  end

  def add_evolution(evolution)
    # ...
  end

  def add_background(background)
    # ...
  end

end
