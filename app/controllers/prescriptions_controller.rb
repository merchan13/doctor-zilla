class PrescriptionsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create, :index]
  before_action :set_prescription, only: [:show, :download]
  respond_to :docx

  def index
    @prescriptions = @record.prescriptions.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def new
    @prescription = @record.prescriptions.new
    @medicine = Medicine.new
    @complete_prescription = @prescription.prescription_medicines.new
  end

  def create
    Prescription.transaction do
      @prescription = @record.prescriptions.create()

      params["prescription"].each do |p|
        #if p["name"] != "" || p["breed"] != ""
          @complete_prescription = @prescription.prescription_medicines.create(prescription_medicines_params(p))
        #end
      end

      if @complete_prescription.save
        flash[:success] = "Prescription was created successfully"
        redirect_to prescription_path(@prescription)
      else
        @prescription = @record.prescriptions.new
        @medicine = Medicine.new
        render 'new'
      end
    end
  end

  def show
    @record = @prescription.medical_record
  end

  def download
    respond_to do |format|
      format.docx do
        render docx: 'download', filename: "recipe_#{@prescription.medical_record.last_name.gsub(/ /, "")}_#{@prescription.id}.docx"
      end
    end
  end

  private
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

    def prescription_medicines_params(my_params)
      my_params.permit( :medicine_id, :dose_way, :dose_presentation, :dose_quantity, :dose_unit, :interval_quantity,
                        :interval_time, :interval_unit, :duration_quantity, :duration_unit, :note )
    end
end
