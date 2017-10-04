class MedicalRecord < ApplicationRecord
  mount_uploader :profile_picture, AvatarUploader

  # User Avatar Validation
  validates_integrity_of  :profile_picture
  validates_processing_of :profile_picture

  #has_many :user_medical_records
  #has_many :users, through: :user_medical_records
  has_many :backgrounds
  has_many :consultations
  has_many :prescriptions
  has_many :attachments
  has_many :reports
  has_many :budgets

  belongs_to :user
  belongs_to :insurance, optional: true
  belongs_to :occupation, optional: true

  validates_presence_of :document,
                        :document_type,
                        :first_consultation_date,
                        :name,
                        :last_name,
                        :birthday,
                        :gender,
                        :phone_number,
                        :address,
                        :occupation,
                        :insurance,
                        :user_id,
                        :message => "es un campo obligatorio."

  validates :document, uniqueness: { scope: [:document_type, :user_id], case_sensitive: false, message: "ya existe en la base de datos." }
  validates :old_record_number, uniqueness: true, allow_nil: true

  def full_name
    return "#{name} #{last_name}".strip if (name || last_name)
    "Anonymous"
  end

  def full_id
    return "#{document_type}-#{document}".strip if (document_type || document)
  end

  def age
    if self.birthday.present?
      dob = self.birthday
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
  end

  def backgrounds_dict
    bgs =  Hash.new
    bgs = { "family" => "",
            "allergy" => "",
            "diabetes" => "",
            "asthma" => "",
            "heart" => "",
            "medicine" => "",
            "surgical" => "",
            "other" => ""}

    self.backgrounds.each do |bg|
      bgs[bg.background_type] = bg.description
    end

    bgs
  end

  def physic_data
    physics =  Hash.new
    physics = { "height" => 0, "weight" => 0, "pressure_d" => "?", "pressure_s" => "?"}

    self.consultations.each do |c|
      physics["height"] = c.height if c.height != nil
      physics["weight"] = c.weight if c.weight != nil
      physics["pressure_d"] = c.pressure_d if c.pressure_d != ""
      physics["pressure_s"] = c.pressure_s if c.pressure_s != ""
    end

    return physics
  end

  def update_background (type, description)
    bg = self.backgrounds.where(background_type: type).first
    if bg.nil?
      if description != ""
        self.backgrounds.create(background_type: type, description: description)
      end
    else
      if description == "" || description == " "
        bg.delete
        self.updated_at = Time.now
        self.save
      else
        bg.description = description
        bg.save
      end
    end
  end

  def report_info_dictionary
    info = Hash.new

    info = {  "operative_notes" => self.operative_notes,
              "physical_exams" => self.physical_exams,
              "plans" => self.plans
            }

    info
  end

  def diagnostics
    diagnostics_hash = Hash.new

    @ordered_consultations = self.consultations.order(created_at: :desc)
    @ordered_consultations.each do |c|

      @diagnostics = c.diagnostics
      @diagnostics.each do  |d|
        if diagnostics_hash["#{c.created_at.strftime('%d %b %Y')}"].nil?
          diagnostics_hash["#{c.created_at.strftime('%d %b %Y')}"] = Array.new
          diagnostics_hash["#{c.created_at.strftime('%d %b %Y')}"] << d
        else
          diagnostics_hash["#{c.created_at.strftime('%d %b %Y')}"] << d
        end
      end
    end

    diagnostics_hash
  end

  def operative_notes
    op_notes = Array.new

    self.consultations.each do |c|
      if !c.plan.nil?
        if !c.plan.operative_note.nil?
          op_notes << c.plan.operative_note
        end
      end
    end

    op_notes
  end

  def physical_exams
    pe = Array.new

    self.consultations.each do |c|
      c.physical_exams.each do  |p|
        pe << p
      end
    end

    pe
  end

  def plans
    plns = Array.new

    self.consultations.each do |c|
      if !c.plan.nil?
        plns << c.plan
      end
    end

    plns
  end

  def latest_pe
    self.consultations.last.physical_exams
  end

  def imc
    if physic_data["weight"] != 0 && physic_data["height"] != 0
      imc = physic_data["weight"]/((physic_data["height"]/100) ** 2)
    else
      imc = 0
    end
  end

  def self.search(param)
    return MedicalRecord.none if param.blank?

    param.strip!

    param.downcase!

    name_matches(param).or(last_name_matches(param).or(document_matches(param)))
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
