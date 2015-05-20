class UsersController < ApplicationController
   before_action :authenticate_user!

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
     if current_user.update_attributes(user_params)
       flash[:notice] = "User information updated"
       redirect_to edit_user_registration_path
     else
       render "devise/registrations/edit"
     end
   end

private
  
  def user_params
    params.require(:user).permit(:name, :image)
  end
end
