class AddReferencesToPrescription < ActiveRecord::Migration[5.0]
  def change
    add_reference :prescriptions, :medical_record, foreign_key: true
  end
end
