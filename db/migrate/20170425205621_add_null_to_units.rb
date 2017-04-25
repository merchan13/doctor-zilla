class AddNullToUnits < ActiveRecord::Migration[5.0]
  def change
    change_column_null :medicines, :interval_unit,  false
    change_column_null :medicines, :dose_unit,      false
    change_column_null :medicines, :duration_unit,  false
  end
end
