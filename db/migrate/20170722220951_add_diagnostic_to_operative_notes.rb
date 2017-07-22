class AddDiagnosticToOperativeNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :operative_notes, :diagnostic, :text
  end
end
