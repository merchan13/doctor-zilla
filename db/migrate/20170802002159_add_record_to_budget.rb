class AddRecordToBudget < ActiveRecord::Migration[5.0]
  def change
    add_reference :budgets, :medical_records, foreign_key: true
  end
end
