class CreateBudget < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets do |t|
      t.float :cost, null: false

      t.timestamps
    end
  end
end
