class ActivitiesController < ApplicationController
  before_action :set_dates

  def general
    @pacients = current_user.medical_records.all
    if @pacients.count > 0
      @all_pacients_without_insurance = Insurance.where('lower(name) LIKE ?', 'sin seguro').first.medical_records
      @pacients_without_insurance = @pacients.where(id: @all_pacients_without_insurance)
      @pacients_with_insurance = @pacients.where.not(id: @pacients_without_insurance)
      @pacients_female = @pacients.where('gender LIKE ?', 'femenine')
      @pacients_male = @pacients.where('gender LIKE ?', 'masculine')
      @pacients_1_10 = @pacients.where(birthday: 11.years.ago..1.years.ago)
      @pacients_11_20 = @pacients.where(birthday: 21.years.ago..11.years.ago)
      @pacients_21_30 = @pacients.where(birthday: 31.years.ago..21.years.ago)
      @pacients_31_40 = @pacients.where(birthday: 41.years.ago..31.years.ago)
      @pacients_41_50 = @pacients.where(birthday: 51.years.ago..41.years.ago)
      @pacients_51_60 = @pacients.where(birthday: 61.years.ago..51.years.ago)
      @pacients_61_70 = @pacients.where(birthday: 71.years.ago..61.years.ago)
      @pacients_71_80 = @pacients.where(birthday: 81.years.ago..71.years.ago)
      @pacients_81_plus = @pacients.where('birthday < ?', 81.years.ago)

      @consultations = Consultation.all
      if @consultations.count > 0
        @consultations_without_insurance = @consultations.where(medical_record: @pacients_without_insurance)
        @consultations_with_insurance = @consultations.where(medical_record: @pacients_with_insurance)
        @consultations_female = @consultations.where(medical_record: @pacients_female)
        @consultations_male = @consultations.where(medical_record: @pacients_male)
        @consultations_1_10 = @consultations.where(medical_record: @pacients_1_10)
        @consultations_11_20 = @consultations.where(medical_record: @pacients_11_20)
        @consultations_21_30 = @consultations.where(medical_record: @pacients_21_30)
        @consultations_31_40 = @consultations.where(medical_record: @pacients_31_40)
        @consultations_41_50 = @consultations.where(medical_record: @pacients_41_50)
        @consultations_51_60 = @consultations.where(medical_record: @pacients_51_60)
        @consultations_61_70 = @consultations.where(medical_record: @pacients_61_70)
        @consultations_71_80 = @consultations.where(medical_record: @pacients_71_80)
        @consultations_81_plus = @consultations.where(medical_record: @pacients_81_plus)

        @procedures = OperativeNote.all
        if @procedures.count > 0
          @plans = Plan.all
          @procedures_without_insurance = @procedures.where(plan: @plans.where(consultation: @consultations_without_insurance))

          @procedures_with_insurance = @procedures.where(plan: @plans.where(consultation: @consultations_with_insurance))
          @procedures_female = @procedures.where(plan: @plans.where(consultation: @consultations_female))
          @procedures_male = @procedures.where(plan: @plans.where(consultation: @consultations_male))
          @procedures_1_10 = @procedures.where(plan: @plans.where(consultation: @consultations_1_10))
          @procedures_11_20 = @procedures.where(plan: @plans.where(consultation: @consultations_11_20))
          @procedures_21_30 = @procedures.where(plan: @plans.where(consultation: @consultations_21_30))
          @procedures_31_40 = @procedures.where(plan: @plans.where(consultation: @consultations_31_40))
          @procedures_41_50 = @procedures.where(plan: @plans.where(consultation: @consultations_41_50))
          @procedures_51_60 = @procedures.where(plan: @plans.where(consultation: @consultations_51_60))
          @procedures_61_70 = @procedures.where(plan: @plans.where(consultation: @consultations_61_70))
          @procedures_71_80 = @procedures.where(plan: @plans.where(consultation: @consultations_71_80))
          @procedures_81_plus = @procedures.where(plan: @plans.where(consultation: @consultations_81_plus))
        else
          set_procedures_variables
        end
      else
        set_consultations_variables
        set_procedures_variables
      end

      @budgets = Budget.all
      if @budgets.count > 0
        @budgets_without_insurance = @budgets.where(medical_record: @pacients_without_insurance)
        @budgets_with_insurance = @budgets.where(medical_record: @pacients_with_insurance)
        @budgets_female = @budgets.where(medical_record: @pacients_female)
        @budgets_male = @budgets.where(medical_record: @pacients_male)
        @budgets_1_10 = @budgets.where(medical_record: @pacients_1_10)
        @budgets_11_20 = @budgets.where(medical_record: @pacients_11_20)
        @budgets_21_30 = @budgets.where(medical_record: @pacients_21_30)
        @budgets_31_40 = @budgets.where(medical_record: @pacients_31_40)
        @budgets_41_50 = @budgets.where(medical_record: @pacients_41_50)
        @budgets_51_60 = @budgets.where(medical_record: @pacients_51_60)
        @budgets_61_70 = @budgets.where(medical_record: @pacients_61_70)
        @budgets_71_80 = @budgets.where(medical_record: @pacients_71_80)
        @budgets_81_plus = @budgets.where(medical_record: @pacients_81_plus)
      else
        set_budgets_variables
      end
    else
      set_records_variables
      set_consultations_variables
      set_procedures_variables
      set_budgets_variables
    end
  end

  def custom
    @_from = params[:from]
    @_to = params[:to]

    @from = Time.parse(@_from)
    @to = Time.parse(@_to)

    if @to >= @from
      general
      render partial: "activities/custom"
    else
      render status: :not_found, nothing: true
    end
  end

  def set_dates
    time = Time.new
    previous_month = time - 1.month
    previous_year = time - 1.year

    @actual_month = time.strftime("%Y-%m-01")
    @previous_month = previous_month.strftime("%Y-%m-01")

    @actual_year = time.strftime("%Y-01-01")
    @previous_year = previous_year.strftime("%Y-01-01")
  end

  def set_records_variables
    none = MedicalRecord.none
    @pacients_without_insurance = none
    @pacients_with_insurance = none
    @pacients_female = none
    @pacients_male = none
    @pacients_1_10 = none
    @pacients_11_20 = none
    @pacients_21_30 = none
    @pacients_31_40 = none
    @pacients_41_50 = none
    @pacients_51_60 = none
    @pacients_61_70 = none
    @pacients_71_80 = none
    @pacients_81_plus = none
  end

  def set_consultations_variables
    none = Consultation.none
    @consultations_without_insurance = none
    @consultations_with_insurance = none
    @consultations_female = none
    @consultations_male = none
    @consultations_1_10 = none
    @consultations_11_20 = none
    @consultations_21_30 = none
    @consultations_31_40 = none
    @consultations_41_50 = none
    @consultations_51_60 = none
    @consultations_61_70 = none
    @consultations_71_80 = none
    @consultations_81_plus = none
  end

  def set_procedures_variables
    none = OperativeNote.none
    @procedures_without_insurance = none
    @procedures_with_insurance = none
    @procedures_female = none
    @procedures_male = none
    @procedures_1_10 = none
    @procedures_11_20 = none
    @procedures_21_30 = none
    @procedures_31_40 = none
    @procedures_41_50 = none
    @procedures_51_60 = none
    @procedures_61_70 = none
    @procedures_71_80 = none
    @procedures_81_plus = none
  end

  def set_budgets_variables
    none = Budget.none
    @budgets_without_insurance = none
    @budgets_with_insurance = none
    @budgets_female = none
    @budgets_male = none
    @budgets_1_10 = none
    @budgets_11_20 = none
    @budgets_21_30 = none
    @budgets_31_40 = none
    @budgets_41_50 = none
    @budgets_51_60 = none
    @budgets_61_70 = none
    @budgets_71_80 = none
    @budgets_81_plus = none
  end

  private
    def user_doctor
      current_user.role == 'Doctor'
    end
end
