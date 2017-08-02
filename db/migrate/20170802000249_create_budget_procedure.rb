class CreateBudgetProcedure < ActiveRecord::Migration[5.0]
  def change
    create_table :budget_procedures do |t|
      t.references :budget, foreign_key: true
      t.references :procedure, foreign_key: true

      t.timestamps
    end
  end
end
