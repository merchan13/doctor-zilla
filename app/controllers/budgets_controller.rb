class BudgetsController < ApplicationController
  before_action :set_medical_record,  only: [:new, :create, :index]
  before_action :set_budget,  only: [:show, :download]
  respond_to :docx

  def index

  end

  def new
    @budget = Budget.new
  end

  def create

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
      params.require(:operative_note).permit( :cost )
    end

end
