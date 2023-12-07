class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :destroy

  def show; end
end
