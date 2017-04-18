class AddDiagnosticReasonToConsultations < ActiveRecord::Migration[5.0]
  def change
    add_reference :consultations, :diagnostic, foreign_key: true
    add_reference :consultations, :reason, foreign_key: true
  end
end
