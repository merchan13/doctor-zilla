class CreateAssistantships < ActiveRecord::Migration[5.0]
  def change
    create_table :assistantships do |t|
      t.references :user, foreign_key: true
      t.references :assistant, class: 'User', foreign_key: true
      
      t.timestamps
    end
  end
end
