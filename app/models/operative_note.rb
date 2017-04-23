class OperativeNote < ApplicationRecord
  belongs_to :plan

  validates_presence_of :description
end
