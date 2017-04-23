class AddPlanToConsultation < ActiveRecord::Migration[5.0]
  def change
    add_reference :consultations, :plan, foreign_key: true
  end
end
