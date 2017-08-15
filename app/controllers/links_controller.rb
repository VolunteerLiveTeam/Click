class LinksController < ApplicationController

  before_action :get_link, only: [:destination, :show]

  def create
    @link = Link.create(link_params)
    redirect_to link_path(@link)
  end

  def new
    @link = Link.new
  end

  def destination
  end

  def show
  end

  private
  def get_link
    @link = Link.find(params[:id])    
  end

  def link_params
    params.require(:link).permit!
  end
  
end
