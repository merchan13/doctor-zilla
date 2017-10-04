class AddNewIndexForRecord < ActiveRecord::Migration[5.0]
  def change
  	add_index :medical_records, [:document_type, :document, :user_id], unique: true, :name => 'index_record_identification_uniqueness'
  end
end
