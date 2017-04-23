class CreatePlanProcedures < ActiveRecord::Migration[5.0]
  def change
    create_table :plan_procedures do |t|
      t.references :plan, foreign_key: true
      t.references :procedure, foreign_key: true

      t.timestamps
    end
  end
end
