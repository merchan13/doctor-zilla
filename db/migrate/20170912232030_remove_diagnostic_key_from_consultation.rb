class RemoveDiagnosticKeyFromConsultation < ActiveRecord::Migration[5.0]
  def change
    remove_reference :consultations, :diagnostic, index:true, foreign_key: true
  end
end
