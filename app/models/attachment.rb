class Attachment < ApplicationRecord
  mount_uploader :url, AttachmentUploader

  # User Avatar Validation
  validates_integrity_of  :url
  validates_processing_of :url

  belongs_to :medical_record
end
