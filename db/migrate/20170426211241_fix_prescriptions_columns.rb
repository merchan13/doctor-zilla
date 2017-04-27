class FixPrescriptionsColumns < ActiveRecord::Migration[5.0]
  def change
    # remove medicines columns
    remove_column :medicines, :dose_way,            :string
    remove_column :medicines, :dose_quantity,       :float
    remove_column :medicines, :dose_unit,           :string
    remove_column :medicines, :interval_quantity,   :float
    remove_column :medicines, :interval_unit,       :string
    remove_column :medicines, :duration_quantity,   :float
    remove_column :medicines, :duration_unit,       :string

    # remove prescription columns
    remove_column :prescriptions, :note, :string

    # add columns to p_m
    add_column    :prescription_medicines, :dose_way,            :string
    add_column    :prescription_medicines, :dose_presentation,   :string
    add_column    :prescription_medicines, :dose_quantity,       :float
    add_column    :prescription_medicines, :dose_unit,           :string
    add_column    :prescription_medicines, :interval_quantity,   :float
    add_column    :prescription_medicines, :interval_unit,       :string
    add_column    :prescription_medicines, :duration_quantity,   :float
    add_column    :prescription_medicines, :duration_unit,       :string
    add_column    :prescription_medicines, :note,   :string

    # change null of comercial_name (medicines)
    change_column_null :medicines, :comercial_name,  true
  end
end
