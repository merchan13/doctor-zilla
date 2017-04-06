class MedicalRecord < ApplicationRecord
  has_many :user_medical_records
  has_many :users, through: :user_medical_records
end
