class CreateUserMedicalRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :user_medical_records do |t|
      t.integer :user_id, null: false
      t.integer :medical_record_id, null: false

      t.timestamps null: false
    end
  end
end
