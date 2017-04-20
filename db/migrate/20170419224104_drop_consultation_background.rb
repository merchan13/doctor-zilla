class DropConsultationBackground < ActiveRecord::Migration[5.0]
  def change
    drop_table :consultation_backgrounds
  end
end
