class AddDatoToSynch < ActiveRecord::Migration[5.0]
  def change
    add_column :synches, :sync_date, :date
  end
end
