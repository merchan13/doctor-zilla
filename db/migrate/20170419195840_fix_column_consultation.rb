class FixColumnConsultation < ActiveRecord::Migration[5.0]
  def change
    add_column :consultations, :pressure_s, :string
    add_column :consultations, :pressure_d, :string
    remove_column :consultations, :pressure, :string
    remove_column :consultations, :temperature, :float
  end
end
