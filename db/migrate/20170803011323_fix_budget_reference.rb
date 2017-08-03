class FixBudgetReference < ActiveRecord::Migration[5.0]
  def change
    add_reference :budgets, :medical_record, foreign_key: true
  end
end
