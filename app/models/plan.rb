class Plan < ApplicationRecord
  belongs_to :consultation
  has_one :operative_note

  has_many :plan_procedures
  has_many :procedures, through: :plan_procedures

  validates_presence_of :description
end
