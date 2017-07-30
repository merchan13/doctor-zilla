class AttachmentReport < ApplicationRecord
  belongs_to :attachment
  belongs_to :report

  validates_presence_of :report_id, :attachment_id
end
