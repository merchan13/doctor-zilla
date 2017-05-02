class PhysicalExam < ApplicationRecord
  belongs_to :consultation

  validates_presence_of :exam_type, :url

  def type_es
    en = self.exam_type

    es = case en
    when 'Head and Neck' then "Cabeza y Cuello"
    when 'Chest' then "Tórax"
    when 'Abdomen' then "Abdomen"
    when 'Genitals' then "Genitales"
    when 'Soft Parts' then "Partes blandas"
    when 'Extremities' then "Extremidades"
    when 'Vascular' then "Vascular"
    when 'Skin' then "Piel"
    when 'Mamma' then "Mamas"
      when 'Others' then "Otros"
      else "Unknown"
    end

    return es
  end
end
