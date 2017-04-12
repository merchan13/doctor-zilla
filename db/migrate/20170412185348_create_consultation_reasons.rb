class CreateConsultationReasons < ActiveRecord::Migration[5.0]
  def change
    create_table :consultation_reasons do |t|
      t.references :consultation, foreign_key: true
      t.references :reason, foreign_key: true

      t.timestamps
    end
  end
end
