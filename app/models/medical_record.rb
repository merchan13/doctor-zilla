class MedicalRecord < ApplicationRecord
  has_many :user_medical_records
  has_many :users, through: :user_medical_records

  private
    def self.numero_nuevo
      MedicalRecord.count + 1
    end

end
