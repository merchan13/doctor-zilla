class Assistantship < ApplicationRecord
  belongs_to :user
  belongs_to :assistant, :class_name => 'User'
end
