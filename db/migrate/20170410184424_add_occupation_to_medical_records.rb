class AddOccupationToMedicalRecords < ActiveRecord::Migration[5.0]
  def change
    add_reference :medical_records, :occupation, foreign_key: true
  end
end
