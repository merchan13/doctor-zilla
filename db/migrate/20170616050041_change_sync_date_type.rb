class ChangeSyncDateType < ActiveRecord::Migration[5.0]
  def change
    remove_column :syncs, :sync_date, :date

    add_column    :syncs, :sync_date, :datetime
  end
end
