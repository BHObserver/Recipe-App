class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    return unless @user.nil?

    flash[:notice] = 'Signed out successfully.'
    redirect_to root_path
  end

end
