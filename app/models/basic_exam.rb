class BasicExam < ApplicationRecord
  belongs_to :consultation

  validates_presence_of :weight, :height, :temperature
end
