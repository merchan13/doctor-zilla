class Medicine < ApplicationRecord
  has_many :prescription_medicines
  has_many :prescriptions, through: :prescription_medicines

  validates_presence_of :comercial_name,  :generic_name, :dose_quantity, :dose_unit, :interval_quantity, :interval_unit,
                        :duration_quantity, :duration_unit
end
