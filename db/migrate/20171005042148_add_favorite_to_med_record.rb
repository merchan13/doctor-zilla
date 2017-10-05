class AddFavoriteToMedRecord < ActiveRecord::Migration[5.0]
  def change
  	add_column :medical_records, :important, :boolean
  end
end
