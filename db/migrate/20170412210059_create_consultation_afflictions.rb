class CreateConsultationAfflictions < ActiveRecord::Migration[5.0]
  def change
    create_table :consultation_afflictions do |t|
      t.references :consultation, foreign_key: true
      t.references :affliction, foreign_key: true

      t.timestamps
    end
  end
end
