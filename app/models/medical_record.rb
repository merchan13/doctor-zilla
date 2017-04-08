class MedicalRecord < ApplicationRecord
  has_many :user_medical_records
  has_many :users, through: :user_medical_records

  validates_presence_of :document, :document_type, :first_consultation_date, :name, :last_name, :birth_date, :gender,
                        :phone_number, :address

  private
    def self.numero_nuevo
      MedicalRecord.count + 1
    end

end
