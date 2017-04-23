class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.text :description, null: false
      t.boolean :emergency

      t.timestamps
    end
  end
end
