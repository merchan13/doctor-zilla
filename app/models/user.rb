class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  validates_presence_of :email, :document, :name, :lastname, :phone, :role
  validates_uniqueness_of :email, :document

  # Historias médicas
  has_many :user_medical_records
  has_many :medical_records, through: :user_medical_records
  # Asistentes
  has_many :assistantships
  has_many :assistants, through: :assistantships

  def full_name
    return "#{name.split(' ')[0]} #{lastname.split(' ')[0]}".strip if (name || lastname)
    "Anonymous"
  end

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

end
