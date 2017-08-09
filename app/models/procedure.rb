class Procedure < ApplicationRecord
  has_many :plan_procedures
  has_many :plans, through: :plan_procedures

  validates_presence_of :name, :description
  validates :name, uniqueness: { case_sensitive: false }

  def cost_in_budget(budget)
    BudgetProcedure.where(budget: budget, procedure: self).first.cost || 0
  end
end
