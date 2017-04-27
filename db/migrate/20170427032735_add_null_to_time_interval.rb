class AddNullToTimeInterval < ActiveRecord::Migration[5.0]
  def change
    change_column_null :prescription_medicines, :interval_time, false
  end
end
