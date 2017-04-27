class AddDateToRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :medical_records, :birthday, :date
  end
end
