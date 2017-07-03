class Background < ApplicationRecord
  belongs_to :medical_record

  validates_presence_of :background_type, :description

  def type_es
    en = self.background_type

    es = case en
      when "family" then "Familiares"
      when "allergy" then "Alergias"
      when "diabetes" then "Diábetes"
      when "asthma" then "Asma"
      when "heart" then "Cardiopatías"
      when "medicine" then "Medicamentos"
      when "surgical" then "Quirúrgicos"
      when "other" then "Otros"
      else "Unknown"
    end

    return es
  end

end
