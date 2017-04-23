class Procedure < ApplicationRecord
  has_many :plan_procedures
  has_many :plans, through: :plan_procedures

  validates_presence_of :name, :description
end
