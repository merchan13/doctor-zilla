class ConsultationBackground < ApplicationRecord
  belongs_to :consultation
  belongs_to :background

  validates_presence_of :consultation_id, :background_id
end
