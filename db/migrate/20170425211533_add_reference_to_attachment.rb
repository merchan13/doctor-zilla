class AddReferenceToAttachment < ActiveRecord::Migration[5.0]
  def change
    add_reference :attachments, :medical_record, foreign_key: true
  end
end
