class DropUserMedicalRecords < ActiveRecord::Migration[5.0]
  def change
  	drop_table :user_medical_records
  end
end
