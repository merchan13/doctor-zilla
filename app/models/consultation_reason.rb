class ConsultationReason < ApplicationRecord
  belongs_to :consultation
  belongs_to :reason

  validates_presence_of :consultation_id, :reason_id
end
