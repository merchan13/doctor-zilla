class CreateOperativeNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :operative_notes do |t|
      t.text :description, null: false
      t.text :find

      t.timestamps
    end
  end
end
