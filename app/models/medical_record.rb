class MedicalRecord < ApplicationRecord
  has_many :user_medical_records
  has_many  :users, through: :user_medical_records
  has_many :consultations

  belongs_to :insurance, optional: true
  belongs_to :occupation, optional: true

  validates_presence_of :document, :document_type, :first_consultation_date, :name, :last_name, :birth_date, :gender,
                        :phone_number, :address

  def full_name
    return "#{name} #{last_name}".strip if (name || last_name)
    "Anonymous"
  end

  def full_id
    return "#{document_type}-#{document}".strip if (document_type || document)
    "Anonymous"
  end

  def self.search(param)
    return MedicalRecord.none if param.blank?

    param.strip!
    param.downcase!
    (name_matches(param) + last_name_matches(param) + document_matches(param)).uniq
  end

  def self.name_matches(param)
    matches('name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.document_matches(param)
    matches('document', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

  private
    def self.numero_nuevo
      MedicalRecord.count + 1
    end

end
