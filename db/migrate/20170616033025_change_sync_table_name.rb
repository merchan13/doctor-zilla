class ChangeSyncTableName < ActiveRecord::Migration[5.0]
  def change
    rename_table :synches, :syncs
  end
end
