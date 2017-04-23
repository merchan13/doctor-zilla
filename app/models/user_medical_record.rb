class UserMedicalRecord < ApplicationRecord
  belongs_to :user
  belongs_to :medical_record

  validates_presence_of :user_id, :medical_record_id
end
