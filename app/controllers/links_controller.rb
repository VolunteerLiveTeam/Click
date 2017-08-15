require 'mini_magick'
require 'uri'

class LinksController < ApplicationController

  before_action :get_link, only: [:destination, :show]

  def create
    new_url = LinksController.process_image(link_params)
    @link = Link.new(link_params)
    @link.image_url = new_url
    @link.save!
    redirect_to link_path(@link)
  end

  def self.process_image(params)
    filename = URI.parse(params[:image_url]).path.split('/').last
    template = MiniMagick::Image.open(Rails.root.join('app', 'assets', 'images', 'VLT-template.png'))
    base = MiniMagick::Image.open(params[:image_url])

    base.resize('1200x630')

    result = base.composite(template) do |c|
      c.compose "over"
      c.gravity "SouthWest"
    end
    result.write(Rails.root.join('public', 'images', filename)) # TODO upload to S3 here

    '/images/' + filename
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
