class CreateAttachmentReport < ActiveRecord::Migration[5.0]
  def change
    create_table :attachment_reports do |t|
      t.references :report, foreign_key: true
      t.references :attachment, foreign_key: true

      t.timestamps
    end
  end
end
