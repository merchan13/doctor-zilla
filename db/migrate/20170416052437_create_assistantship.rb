class CreateAssistantship < ActiveRecord::Migration[5.0]
  def change
    create_table :assistantships do |t|
      t.belongs_to :user
      t.belongs_to :assistant, class: 'User'
      
      t.timestamps null: false
    end
  end
end
