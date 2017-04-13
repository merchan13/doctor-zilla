class CreateConsultationBackgrounds < ActiveRecord::Migration[5.0]
  def change
    create_table :consultation_backgrounds do |t|
      t.references :consultation, foreign_key: true
      t.references :background, foreign_key: true

      t.timestamps
    end
  end
end
