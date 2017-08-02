class Equipment < ApplicationRecord
  has_many :budget_equipments
  has_many :budgets, through: :budget_equipments

  validates :name, presence: true 
  validates :name, uniqueness: { case_sensitive: false }
end
