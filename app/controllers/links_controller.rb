class LinksController < ApplicationController
  before_action :set_link, only: ["show"]

  def create
    link = Link.create!(link_params)
    
    render json: LinkBlueprint.render(link), status: :created
  end

  def show
    render json: LinkBlueprint.render(@link)
  end

  private

  def link_params
    params.permit(:original_url)
  end

  def set_link
    @link = Link.find_by(shortened_url: params[:shortened_url])
    
    raise ActiveRecord::RecordNotFound unless @link
  end
end
