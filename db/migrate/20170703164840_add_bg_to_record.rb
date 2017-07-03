class AddBgToRecord < ActiveRecord::Migration[5.0]
  def change
    add_reference :backgrounds, :medical_record, foreign_key: true
  end
end
