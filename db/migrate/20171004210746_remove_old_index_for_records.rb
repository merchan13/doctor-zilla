class RemoveOldIndexForRecords < ActiveRecord::Migration[5.0]
  def change
  	remove_index :medical_records, name: :index_medical_records_on_document_type_and_document
  end
end
