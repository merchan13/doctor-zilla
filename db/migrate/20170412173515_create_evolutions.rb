class CreateEvolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :evolutions do |t|
      t.text :description, null: false
      t.references :consultation, foreign_key: true

      t.timestamps
    end
  end
end
