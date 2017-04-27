class PrescriptionMedicine < ApplicationRecord
  belongs_to :prescription
  belongs_to :medicine

  validates_presence_of :dose_way, :dose_presentation, :dose_quantity, :dose_unit, :interval_quantity, :interval_unit,
                        :interval_time, :duration_quantity, :duration_unit
end
