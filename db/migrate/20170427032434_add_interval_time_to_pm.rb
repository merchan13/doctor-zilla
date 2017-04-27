class AddIntervalTimeToPm < ActiveRecord::Migration[5.0]
  def change
    add_column :prescription_medicines, :interval_time, :float
  end
end
