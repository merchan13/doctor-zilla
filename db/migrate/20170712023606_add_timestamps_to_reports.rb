class AddTimestampsToReports < ActiveRecord::Migration[5.0]
  def change
    add_column(:reports, :created_at, :datetime)
    add_column(:reports, :updated_at, :datetime)
  end
end
