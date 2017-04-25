class CreateMedicines < ActiveRecord::Migration[5.0]
  def change
    create_table :medicines do |t|
      t.string  :comercial_name,      null: false
      t.string  :generic_name,        null: false
      t.string  :dose_way
      t.float   :dose_quantity,       null: false
      t.float   :dose_unit,           null: false
      t.float   :interval_quantity,   null: false
      t.float   :intervalo_unit,      null: false
      t.float   :duration_quantity,   null: false
      t.float   :duration_unit,       null: false

      t.timestamps
    end
  end
end
