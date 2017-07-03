class Consultation < ApplicationRecord
  belongs_to :medical_record

  has_many :physical_exams
  belongs_to :reason, optional: true
  belongs_to :diagnostic, optional: true
  has_one :plan

  # Recibo un array con todos los examenes fisicos.
  def add_physical_exams(physical_exams, exams_descriptions)
    physical_exams.each do |exam|
      if physical_exams[exam] == '1'
        self.physical_exams << PhysicalExam.create( exam_type: white_list_exam_type(exam), url: 'unknown', observation: exams_descriptions[exam] )
      end
    end
  end

  def add_backgrounds(backgrounds)
    backgrounds.each do |background|
      if !backgrounds[background].blank?
        if self.medical_record.backgrounds.where(background_type: background).count > 0
          bg_id = self.medical_record.backgrounds.where(background_type: background).first.id
          bg = Background.find(bg_id)
          description = bg.description + "\r\n" + backgrounds[background]
          puts "AQUI VA LA DESCRIPCION NUEVAAAAA::::: #{description}"
          bg.description = description
          bg.save
        else
          self.medical_record.backgrounds.create(background_type: background, description: backgrounds[background])
        end
      end
    end
  end

  def add_plan(plan)
    Plan.create(description: plan[:description])
    self.plan = Plan.last
  end

  def add_procedure(procedures)
    procedures.each do |p|
      self.plan.procedures << Procedure.find(p)
    end
  end

  def imc
    result = self.weight/((self.height/100) ** 2)
  end

end
