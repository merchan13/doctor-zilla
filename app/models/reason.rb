class Reason < ApplicationRecord
  has_many :consultations

  validates_presence_of :description
  validates :description, uniqueness: { case_sensitive: false }
end
