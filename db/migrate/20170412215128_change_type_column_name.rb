class ChangeTypeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :physical_exams, :type, :exam_type
  end
end
