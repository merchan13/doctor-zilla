class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.text    :description,   null: false
      t.string  :url,           null: false

      t.timestamps
    end
  end
end
