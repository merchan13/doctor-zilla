class AddIndexForRecordIdentification < ActiveRecord::Migration[5.0]
  def change
    add_index :medical_records, [:document_type, :document], unique: true
  end
end
