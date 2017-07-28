class Prescription < ApplicationRecord
  belongs_to :medical_record

  has_many :prescription_medicines
  has_many :medicines, through: :prescription_medicines

  def medicines_list
    list = ""

    self.medicines.each do |m|
      list+= "#{m.comercial_name} (#{m.generic_name}) | "
    end

    list
  end

  def prescriptions_list
    list = ""

    self.prescription_medicines.each do |x|
      list += "- #{x.medicine.comercial_name} (#{x.medicine.generic_name}), #{x.medicine.dose_presentation} #{x.medicine.dose_quantity.round} #{x.medicine.dose_unit}.<br><br>"
    end

    list
  end

  def indications_list
    list = ""

    self.prescription_medicines.each do |x|
      list += "- #{x.medicine.comercial_name} (#{x.medicine.generic_name}), #{x.interval_quantity.round} #{x.medicine.dose_presentation} #{x.medicine.dose_quantity.round} #{x.medicine.dose_unit}, vía #{x.medicine.dose_way} cada #{x.interval_time.round} #{x.interval_unit} por #{x.duration_quantity.round} #{x.duration_unit} #{x.note}.<br><br>"
    end

    list
  end
end
