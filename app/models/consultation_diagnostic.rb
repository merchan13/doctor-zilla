class ConsultationDiagnostic < ApplicationRecord
  belongs_to :consultation
  belongs_to :diagnostic

  validates_presence_of :consultation_id, :diagnostic_id
end
