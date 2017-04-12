class CreateBasicExams < ActiveRecord::Migration[5.0]
  def change
    create_table :basic_exams do |t|
      t.float :weight, null: false
      t.float :height, null: false
      t.float :temperature, null: false
      t.string :pressure
      t.references :consultation, foreign_key: true

      t.timestamps
    end
  end
end
