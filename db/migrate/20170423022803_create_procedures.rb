class CreateProcedures < ActiveRecord::Migration[5.0]
  def change
    create_table :procedures do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.float :cost

      t.timestamps
    end
  end
end
