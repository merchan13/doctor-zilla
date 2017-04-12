class PhysicalExam < ApplicationRecord
  has_many :consultation_physical_exams
  has_many :consultations, through: :consultation_physical_exams

  validates_presence_of :exam_type, :url
end
