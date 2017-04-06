class UserMedicalRecord < ApplicationRecord
  belongs_to :user
  belongs_to :medical_record
end
