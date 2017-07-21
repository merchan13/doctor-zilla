# encoding: utf-8
class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.medical_record.last_name.gsub(/ /, "")}_#{model.medical_record.id}/#{model.class.to_s.underscore}s/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(pdf doc htm html docx jpg jpeg gif png)
  end
end
