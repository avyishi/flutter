class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @flits = @user.flits.paginate(page: params[:page])
  end
end
