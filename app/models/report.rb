class Report < ApplicationRecord
  belongs_to :medical_record

  validates_presence_of :description
end
