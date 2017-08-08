class BudgetsController < ApplicationController
  before_action :set_medical_record,  only: [:new, :create, :index]
  before_action :set_budget,  only: [:show, :download]
  respond_to :docx

  def index
    @budgets = @record.budgets.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def new
    @budget = Budget.new
  end

  def create
    Budget.transaction do

      @budget = @record.budgets.create(budget_params)

      params["procedures"].each_with_index do |pr, i|
          @budget.budget_procedures.create(procedure_id: pr, cost: params[:procedures_cost][i])
      end

      params["equipments"].each_with_index do |eq, i|
          @budget.budget_equipments.create(equipment_id: eq, cost: params[:equipments_cost][i])
      end

      if @budget.save
        flash[:success] = "Nuevo Presupuesto creado exitósamente"
        #redirect_to budget_path(@budget)
        redirect_to root_path
      else
        @budget = Budget.new
        render 'new'
      end

    end
  end

  def show

  end

  def download
    respond_to do |format|
      format.docx do
        render docx: 'download', filename: "notaOperatoria_#{@record.last_name.gsub(/ /, "")}_#{@operative_note.id}.docx"
      end
    end
  end

  private
    def set_budget
      @budget = Budget.find(params[:id])
      @record = @budget.medical_record
      @procedures = @budget.procedures
      @equipments = @budget.equipments
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

    def budget_params
      params.require(:budget).permit( :cost )
    end

end
