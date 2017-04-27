class RemoveOldBirthdate < ActiveRecord::Migration[5.0]
  def change
    remove_column :medical_records, :birth_date, :datetime
  end
end
