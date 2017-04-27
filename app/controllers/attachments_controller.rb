class AttachmentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    @attachment = Attachment.create(attachment_params)

    if @attachment.save
      flash[:success] = "New attachment added"
    else
      #render status: :not_found, nothing: true
    end
  end

  private
    def attachment_params
      params.require(:attachment).permit( :description, :url, :url_cache, :remove_url, :medical_record_id )
    end

end
