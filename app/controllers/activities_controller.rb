class ActivitiesController < ApplicationController

  def general
    @pacients = MedicalRecord.all
    @consultations = Consultation.all
    @procedures = OperativeNote.all
    @budgets = Budget.all

    if @pacients.count > 0
      @pacients_without_insurance = Insurance.where('lower(name) LIKE ?', 'sin seguro').first.medical_records
      @pacients_with_insurance = @pacients - @pacients_without_insurance
      @pacients_female = @pacients.where('gender LIKE ?', 'femenine')
      @pacients_male = @pacients - @pacients_female
      @pacients_1_10 = @pacients.where(birthday: 11.years.ago..1.years.ago)
      @pacients_11_20 = @pacients.where(birthday: 21.years.ago..11.years.ago)
      @pacients_21_30 = @pacients.where(birthday: 31.years.ago..21.years.ago)
      @pacients_31_40 = @pacients.where(birthday: 41.years.ago..31.years.ago)
      @pacients_41_50 = @pacients.where(birthday: 51.years.ago..41.years.ago)
      @pacients_51_60 = @pacients.where(birthday: 61.years.ago..51.years.ago)
      @pacients_61_70 = @pacients.where(birthday: 71.years.ago..61.years.ago)
      @pacients_71_80 = @pacients.where(birthday: 81.years.ago..71.years.ago)
      @pacients_81_plus = @pacients.where('birthday < ?', 81.years.ago)
    end

    if @consultations.count > 0

    end

    if @procedures.count > 0
    end

    if @budgets.count > 0
    end

  end

  private
    def user_doctor
      current_user.role == 'Doctor'
    end
end
