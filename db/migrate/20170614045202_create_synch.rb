class CreateSynch < ActiveRecord::Migration[5.0]
  def change
    create_table :synches do |t|
      t.text    :description
      t.timestamps
    end
  end
end
