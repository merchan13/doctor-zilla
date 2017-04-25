class CreatePrescriptionMedicines < ActiveRecord::Migration[5.0]
  def change
    create_table :prescription_medicines do |t|
      t.references :prescription, foreign_key: true
      t.references :medicine, foreign_key: true

      t.timestamps
    end
  end
end
