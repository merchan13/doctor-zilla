class AddNotNullToMedicines < ActiveRecord::Migration[5.0]
  def change
    change_column_null :medicines, :dose_way,            false
    change_column_null :medicines, :dose_presentation,   false
    change_column_null :medicines, :dose_quantity,       false
    change_column_null :medicines, :dose_unit,           false
  end
end
