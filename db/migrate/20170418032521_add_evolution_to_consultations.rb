class AddEvolutionToConsultations < ActiveRecord::Migration[5.0]
  def change
    add_column :consultations, :evolution, :text
    add_column :consultations, :note, :text
    add_column :consultations, :affliction, :text
    add_column :consultations, :weight, :float
    add_column :consultations, :height, :float
    add_column :consultations, :temperature, :float
    add_column :consultations, :pressure, :string
  end
end
