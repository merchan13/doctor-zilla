class DropTables < ActiveRecord::Migration[5.0]
  def change
    drop_table :notes
    drop_table :evolutions
    drop_table :consultation_physical_exams
    drop_table :consultation_reasons
    drop_table :consultation_afflictions
    drop_table :consultation_diagnostics
    drop_table :reasons
  end
end
