class Consultation < ApplicationRecord
  belongs_to :medical_record

  # Antecedentes
  has_many :backgrounds
  # Examen fisico
  has_many :physical_exams
  # Motivos de consulta
  belongs_to :reason, optional: true
  # Diagnóstico
  belongs_to :diagnostic, optional: true



  # Recibo un array con todos los examenes fisicos.
  def add_physical_exam(physical_exam)
    # ...
  end

  def add_backgrounds(backgrounds)
    backgrounds.each do |background|
      if !backgrounds[background].blank?
        self.backgrounds << Background.create(background_type: background, description: backgrounds[background])
      end
    end
  end

  def imc(weight, height)
    result = weight/(height ** 2) 
  end

end
