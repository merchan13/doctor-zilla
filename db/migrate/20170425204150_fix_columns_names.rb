class FixColumnsNames < ActiveRecord::Migration[5.0]
  def change
    add_column :medicines, :interval_unit, :float
    remove_column :medicines, :intervalo_unit, :float
    remove_column :prescriptions, :interval_unit, :float
  end
end
