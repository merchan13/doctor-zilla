class BudgetEquipment < ApplicationRecord
  belongs_to :budget
  belongs_to :equipment

  validates_presence_of :budget_id, :equipment_id
end
