class Plan < ApplicationRecord
  belongs_to :consultation
  has_one :operative_note

  has_many :plan_procedures
  has_many :procedures, through: :plan_procedures

  validates_presence_of :description

  def self.search(param, medical_records)
    return Plan.none if param.blank?

    plans_in_records = Array.new

    param.strip!
    param.downcase!

    medical_records.search(param).each do |mr|
      mr.consultations.each do |c|
        unless c.plan.nil?
          plans_in_records << c.plan
        end
      end
    end

    plans_in_records
  end

end
