class CreateMedicalRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :medical_records do |t|
      t.string :document,                     null: false
      t.string :document_type,                null: false
      t.datetime :first_consultation_date,    null: false
      t.string :name,                         null: false
      t.string :last_name,                    null: false
      t.datetime :birth_date,                 null: false
      t.string :gender,                       null: false
      t.string :phone_number
      t.string :cellphone_number
      t.text :address,                        null: false
      t.string :email
      t.string :referred_by,                  null: false
      t.string :profile_picture
      t.string :representative_document

      t.timestamps null: false
    end
  end
end
