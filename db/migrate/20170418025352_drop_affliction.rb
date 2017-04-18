class DropAffliction < ActiveRecord::Migration[5.0]
  def change
    drop_table :afflictions
  end
end
