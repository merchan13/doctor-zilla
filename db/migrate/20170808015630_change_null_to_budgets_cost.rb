class ChangeNullToBudgetsCost < ActiveRecord::Migration[5.0]
  def change
    change_column_null :budget_equipments, :cost,   false
    change_column_null :budget_procedures, :cost,   false
  end
end
