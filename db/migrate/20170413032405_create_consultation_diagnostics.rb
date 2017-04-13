class CreateConsultationDiagnostics < ActiveRecord::Migration[5.0]
  def change
    create_table :consultation_diagnostics do |t|
      t.references :consultation, foreign_key: true
      t.references :diagnostic, foreign_key: true

      t.timestamps
    end
  end
end
