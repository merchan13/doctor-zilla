class MedicalRecordsController < ApplicationController
  before_action :set_record, only: [:edit, :update, :show]
  before_action :set_others, only: [:edit, :update, :new, :create, :show]
  before_action :set_attachments, only: [:edit, :update, :show]
  before_action :set_consultations, only: [:show]
  # bloqueo de secretarias
  before_action :doctors_only, only: [:edit, :update]

  def doctors_only
    if current_user.role != "Doctor"
      doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
      flash[:warning] = "Sólo el Doctor #{doctor.full_name} pueden realizar esa acción"
      redirect_to medical_record_path(@record)
    end
  end

  def index
    if current_user.role == "Doctor"
      @records = current_user.medical_records.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    elsif current_user.role == "Ayudante"
      doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
      @records = doctor.medical_records.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    end
  end

  def new
    @record = current_user.medical_records.new
  end

  def create
    MedicalRecord.transaction do
      @record = current_user.medical_records.create(record_params)
      if @record.save
        flash[:success] = "Historia Médica creada exitósamente"
        redirect_to medical_record_path(@record)
      else
        render 'new'
      end
    end
  end

  def edit
    # ...
  end

  def update
    MedicalRecord.transaction do
      @record.update_background("family", params["bg_family"])
      @record.update_background("allergy", params["bg_allergy"])
      @record.update_background("diabetes", params["bg_diabetes"])
      @record.update_background("asthma", params["bg_asthma"])
      @record.update_background("heart", params["bg_heart"])
      @record.update_background("medicine", params["bg_medicine"])
      @record.update_background("surgical", params["bg_surgical"])
      @record.update_background("other", params["bg_other"])

      if @record.update(record_params)
        flash[:success] = "Historia Médica actualizada exitósamente"
        redirect_to medical_record_path(@record)
      else
        render 'edit'
      end
    end
  end

  def show
    # ...
  end

  def search
    @filter = params[:filter]

    if current_user.role == "Doctor"
      @records = current_user.medical_records.search(params[:search_param])
    elsif current_user.role == "Ayudante"
      doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
      @records = doctor.medical_records.search(params[:search_param])
    end

    if @records
      render partial: "medical_records/lookup"
    else
      render status: :not_found, nothing: true
    end
  end

  private
    def record_params
      params.require(:medical_record).permit( :document, :document_type, :first_consultation_date, :name, :last_name,
                                              :birthday, :gender, :phone_number, :cellphone_number, :address, :email,
                                              :referred_by, :profile_picture, :representative_document, :occupation_id,
                                              :insurance_id, :profile_picture_cache, :remove_profile_picture, :old_record_number )
    end

    def set_record
      if current_user.role == "Doctor"
        @record = current_user.medical_records.find(params[:id])
      elsif current_user.role == "Ayudante"
        doctor = User.find(Assistantship.where(assistant_id:current_user.id).first.user_id)
        @record = doctor.medical_records.find(params[:id])
      end
    end

    def set_others
      @occupation = Occupation.new
      @insurance = Insurance.new
    end

    def set_attachments
      @my_attachments = @record.attachments.paginate(page: params[:page], per_page: 20)
    end

    def set_consultations
      @consultations = @record.consultations.order(created_at: :desc)
    end
end
