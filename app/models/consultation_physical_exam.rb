class ConsultationPhysicalExam < ApplicationRecord
  belongs_to :consultation
  belongs_to :physical_exam

  validates_presence_of :consultation_id, :physical_exam_id
end
