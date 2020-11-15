class PagesController < ApplicationController
  # def show
  # end

  def permalink
    @page = Page.find_by(permalink: params[:permalink])
  end
end
