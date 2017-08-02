class Occupation < ApplicationRecord
  has_many :medical_records

  validates_presence_of :name
  validates :name, uniqueness: { case_sensitive: false }
end
