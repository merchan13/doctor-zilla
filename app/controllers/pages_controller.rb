class PagesController < ApplicationController

  def index
  end

  def home
    @option_selected = params[:page]
    render template: "pages/#{params[:page]}"
  end

end
