class AddNullToInsuranceName < ActiveRecord::Migration[5.0]
  def change
    change_column_null :insurances, :name, false
  end
end
