class Drop < ActiveRecord::Migration[5.0]
  def change
    drop_table :medical_records
  end
end
