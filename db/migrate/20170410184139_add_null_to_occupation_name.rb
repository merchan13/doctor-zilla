class AddNullToOccupationName < ActiveRecord::Migration[5.0]
  def change
    change_column_null :occupations, :name, false
  end
end
