class AddNullToIntervalUnit < ActiveRecord::Migration[5.0]
  def change
    change_column_null :medicines, :interval_unit, false
  end
end
