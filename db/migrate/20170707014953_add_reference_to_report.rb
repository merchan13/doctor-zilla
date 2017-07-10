class AddReferenceToReport < ActiveRecord::Migration[5.0]
  def change
    add_reference :reports, :medical_record, foreign_key: true
  end
end
