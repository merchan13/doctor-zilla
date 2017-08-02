class CreateBudgetEquipment < ActiveRecord::Migration[5.0]
  def change
    create_table :budget_equipments do |t|
      t.references :budget, foreign_key: true
      t.references :equipment, foreign_key: true

      t.timestamps
    end
  end
end
