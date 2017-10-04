class AddNotNullToUserId < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :medical_records, :user_id, false
  end
end
