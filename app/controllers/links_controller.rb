class LinksController < ApplicationController
  before_action :authenticate_user!, only: :destroy

  def destroy
    @link = Link.find_by(id: params[:id])
    @link.destroy if current_user.author?(@link.linkable)
  end
end
