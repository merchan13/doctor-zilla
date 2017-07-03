class RemoveBgFromConsultation < ActiveRecord::Migration[5.0]
  def change
    remove_column :backgrounds, :consultation_id
  end
end
