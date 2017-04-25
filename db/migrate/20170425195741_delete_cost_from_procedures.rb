class DeleteCostFromProcedures < ActiveRecord::Migration[5.0]
  def change
    remove_column :procedures, :cost, :float
  end
end
