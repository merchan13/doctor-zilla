class AddOldRecordNumberToMedicalRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medical_records, :old_record_number, :string
  end
end
