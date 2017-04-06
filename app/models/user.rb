class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_medical_records
  has_many :medical_records, through: :user_medical_records

  def full_name
    return "#{name.split(' ')[0]} #{lastname.split(' ')[0]}".strip if (name || lastname)
    "Anonymous"
  end

end
