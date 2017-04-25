class Prescription < ApplicationRecord
  belongs_to :medical_record

  has_many :prescription_medicines
  has_many :medicines, through: :prescription_medicines
end
