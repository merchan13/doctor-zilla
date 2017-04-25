class ChangeColumnsType < ActiveRecord::Migration[5.0]
  def change
    remove_column :medicines, :interval_unit,   :float
    remove_column :medicines, :dose_unit,       :float
    remove_column :medicines, :duration_unit,   :float
    add_column    :medicines, :dose_unit,       :string
    add_column    :medicines, :interval_unit,   :string
    add_column    :medicines, :duration_unit,   :string
  end
end
