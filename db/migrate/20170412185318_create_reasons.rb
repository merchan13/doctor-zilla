class CreateReasons < ActiveRecord::Migration[5.0]
  def change
    create_table :reasons do |t|
      t.text :description, null: false

      t.timestamps
    end
  end
end
