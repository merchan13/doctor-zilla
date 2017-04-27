class ChangeNameOfColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :prescriptions, :interval_unit, :float
  end
end
