class AddReferencesToOperativeNote < ActiveRecord::Migration[5.0]
  def change
    add_reference :operative_notes, :plan, foreign_key: true
  end
end
