class ConsultationAffliction < ApplicationRecord
  belongs_to :consultation
  belongs_to :affliction

  validates_presence_of :consultation_id, :affliction_id
end
