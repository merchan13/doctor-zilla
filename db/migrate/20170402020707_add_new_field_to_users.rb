class AddNewFieldToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :document, :string
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :phone, :string
    add_column :users, :role, :string
    add_index :users, :document,             unique: true
  end

end
