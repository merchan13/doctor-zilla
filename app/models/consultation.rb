class Consultation < ApplicationRecord
  belongs_to :medical_record

  # Antecedentes
  has_many :consultation_backgrounds
  has_many :backgrounds, through: :consultation_backgrounds
  # Examen fisico
  has_many :physical_exams
  # Motivos de consulta
  belongs_to :reason, optional: true
  # Diagnóstico
  belongs_to :diagnostic, optional: true


  def add_reason(reason)
    self.reasons << Reason.find(reason)
  end

  # Recibo un array con todos los examenes fisicos.
  def add_physical_exam(physical_exam)
    # ...
  end

  def add_background(background)
    # ...
  end

end
