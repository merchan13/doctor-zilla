class Medicine < ApplicationRecord
  has_many :prescription_medicines
  has_many :prescriptions, through: :prescription_medicines

  validates_presence_of :generic_name, :dose_way, :dose_presentation, :dose_unit, :dose_quantity
end
