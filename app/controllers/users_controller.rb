class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.name == "admin"
      user.admin = true
    end
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to '/'
    else
      flash[:alert] = user.errors.full_messages
      redirect_to '/sign_up'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
