class PrescriptionsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create]
  before_action :set_prescription, only: [:edit, :update, :show]

  def index
    # ...
  end

  def new
    @prescription = @record.prescriptions.new
    @medicine = Medicine.new
  end

  def create
    # ...
  end

  def show
    # ...
  end

  private
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

end
