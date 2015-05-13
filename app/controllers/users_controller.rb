class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    @user = User.create( user_params )
  end

  def show
    @user = User.find(params[:id])
    @flits = @user.flits.paginate(page: params[:page])
  end

  def update
    if user.save
      sign_in_and_redirect user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end

private
  
  def user_params
    params.require(:user).permit(:name, :image)
  end
end
