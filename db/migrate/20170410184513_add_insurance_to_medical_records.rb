class AddInsuranceToMedicalRecords < ActiveRecord::Migration[5.0]
  def change
    add_reference :medical_records, :insurance, foreign_key: true
  end
end
