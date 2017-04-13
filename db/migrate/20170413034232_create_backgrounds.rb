class CreateBackgrounds < ActiveRecord::Migration[5.0]
  def change
    create_table :backgrounds do |t|
      t.string :background_type, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
