class CreatePhysicalExams < ActiveRecord::Migration[5.0]
  def change
    create_table :physical_exams do |t|
      t.string :type, null: false
      t.string :url, null: false
      t.text :observation

      t.timestamps
    end
  end
end
