class Budget < ApplicationRecord
  belongs_to :medical_record

  has_many :budget_procedures
  has_many :procedures, through: :budget_procedures

  has_many :budget_equipments
  has_many :equipments, through: :budget_equipments

  validates :cost, presence: true
end
