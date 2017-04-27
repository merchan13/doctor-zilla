class AddNullToPM < ActiveRecord::Migration[5.0]
  def change
    change_column_null :prescription_medicines, :dose_way,   false
    change_column_null :prescription_medicines, :dose_presentation,   false
    change_column_null :prescription_medicines, :dose_quantity,       false
    change_column_null :prescription_medicines, :dose_unit,           false
    change_column_null :prescription_medicines, :interval_quantity,   false
    change_column_null :prescription_medicines, :interval_unit,       false
    change_column_null :prescription_medicines, :duration_quantity,   false
    change_column_null :prescription_medicines, :duration_unit,       false
  end
end
