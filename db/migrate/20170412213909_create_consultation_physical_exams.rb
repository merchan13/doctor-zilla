class CreateConsultationPhysicalExams < ActiveRecord::Migration[5.0]
  def change
    create_table :consultation_physical_exams do |t|
      t.references :consultation, foreign_key: true
      t.references :physical_exam, foreign_key: true

      t.timestamps
    end
  end
end
