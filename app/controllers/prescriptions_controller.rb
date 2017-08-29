class PrescriptionsController < ApplicationController
  before_action :set_medical_record,  only: [:new, :create, :index]
  before_action :set_prescription,    only: [:show, :download]
  respond_to :docx
  # bloqueo de secretarias
  before_action :doctors_only, only: [:new, :create]

  def doctors_only
    if current_user.role != "Doctor"
      doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
      flash[:warning] = "Sólo el Doctor #{doctor.full_name} pueden realizar esa acción"
      redirect_to medical_record_path(@record)
    end
  end

  def index
    @prescriptions = @record.prescriptions.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def new
    @prescription = @record.prescriptions.new
    @complete_prescription = @prescription.prescription_medicines.new
  end

  def create
    Prescription.transaction do
      @prescription = @record.prescriptions.create()

      prescription_params["prescription"].each do |params|
          @complete_prescription = @prescription.prescription_medicines.create(params)
      end

      if @complete_prescription.save
        flash[:success] = "Récipe nuevo creado exitósamente."
        redirect_to prescription_path(@prescription)
      else
        @prescription = @record.prescriptions.new
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

    def prescription_params
      params.permit(:prescription => [:interval_quantity, :interval_time, :interval_unit, :duration_quantity, :duration_unit, :note, :medicine_id])
      #params.require(:prescription).permit()
    end
end
