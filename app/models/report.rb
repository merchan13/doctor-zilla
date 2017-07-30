class Report < ApplicationRecord
  belongs_to :medical_record

  has_many :attachment_reports
  has_many :attachments, through: :attachment_reports

  validates_presence_of :description
end
