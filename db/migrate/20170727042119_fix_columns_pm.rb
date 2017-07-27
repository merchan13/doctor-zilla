class FixColumnsPm < ActiveRecord::Migration[5.0]
  def change
    add_column  :medicines, :dose_way,          :string
    add_column  :medicines, :dose_presentation, :string
    add_column  :medicines, :dose_quantity,     :float
    add_column  :medicines, :dose_unit,         :string

    remove_column   :prescription_medicines, :dose_way,          :string
    remove_column   :prescription_medicines, :dose_presentation, :string
    remove_column   :prescription_medicines, :dose_quantity,     :float
    remove_column   :prescription_medicines, :dose_unit,         :string
  end
end
