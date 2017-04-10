class Occupation < ApplicationRecord
  has_many :medical_records

  validates_presence_of :name
  validates_uniqueness_of :name
end
