class PhysicalExam < ApplicationRecord
  belongs_to :consultation

  validates_presence_of :exam_type, :url
end
