class Assistantship < ApplicationRecord
  belongs_to :user
  #belongs_to :doctor, :class_name => 'User'
  belongs_to :assistant, :class_name => 'User'
end
