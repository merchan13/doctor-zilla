class AddReferencesToPlan < ActiveRecord::Migration[5.0]
  def change
    add_reference :plans, :consultation, foreign_key: true
    add_reference :plans, :operative_note, foreign_key: true
  end
end
