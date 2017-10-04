class AddUserReferenceToRecord < ActiveRecord::Migration[5.0]
  def change
  	add_reference :medical_records, :user, foreign_key: true
  end
end
