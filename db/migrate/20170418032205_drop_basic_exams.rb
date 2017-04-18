class DropBasicExams < ActiveRecord::Migration[5.0]
  def change
    drop_table :basic_exams
  end
end
