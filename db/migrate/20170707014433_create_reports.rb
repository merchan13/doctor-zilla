class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :report_type, null: false
      t.text :description, null: false
    end
  end
end
