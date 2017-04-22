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
  def add_physical_exams(physical_exams, exams_descriptions)
    physical_exams.each do |exam|
      if physical_exams[exam] == '1'
        self.physical_exams << PhysicalExam.create( exam_type: white_list_exam_type(exam), url: 'physical_exams/xxx.png', observation: exams_descriptions[exam] )
      end
    end
  end

  def white_list_exam_type(pre_type)
    if pre_type == 'cc'
      type = 'Head and Neck'
    elsif pre_type == 'tx'
      type = 'Chest'
    elsif pre_type == 'ab'
      type = 'Abdomen'
    elsif pre_type == 'gn'
      type = 'Genitals'
    elsif pre_type == 'pb'
      type = 'Soft Parts'
    elsif pre_type == 'ex'
      type = 'Extremities'
    elsif pre_type == 'vs'
      type = 'Vascular'
    elsif pre_type == 'pl'
      type = 'Skin'
    elsif pre_type == 'mm'
      type = 'Mamma'
    elsif pre_type == 'otros'
      type = 'Others'
    end
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
