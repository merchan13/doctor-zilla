class AttachmentsController < ApplicationController
  before_action :set_medical_record, only: [:new, :create, :index]
  before_action :set_attachment, only: [:destroy]

  def index
    @attachments = @record.attachments.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def new
    @attachment = @record.attachments.new
  end

  def create
    Attachment.transaction do
      @attachment = @record.attachments.create(attachment_params)

      if @attachment.save
        flash[:success] = "New attachment added"
        redirect_to attachments_path(record: @record)
      else
        render 'new'
      end
    end
  end

  def destroy
    Attachment.transaction do
      @record = @attachment.medical_record

      @attachment.destroy

      flash[:success] = "Anexo eliminado"
      redirect_to attachments_path(record: @record)
    end
  end

  private
    def attachment_params
      params.require(:attachment).permit( :description, :url, :url_cache, :remove_url)
    end

    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end
end
