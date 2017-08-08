class AddCostToBudgetsRelationships < ActiveRecord::Migration[5.0]
  def change
    add_column :budget_equipments, :cost, :float
    add_column :budget_procedures, :cost, :float
  end
end
