class BudgetProcedure < ApplicationRecord
  belongs_to :budget
  belongs_to :procedure

  validates_presence_of :budget_id, :procedure_id
end
