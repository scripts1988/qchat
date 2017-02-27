class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email]) 
    if @user
      if @user.authenticate(params[:password])
        flash[:success] = "You signed in as " + @user.name
        redirect_to root_path
      else
        flash.now[:error] = "Incorrect password"
        render new 
      end
    else
        flash.now[:error] = "Email not found " + params[:email]
        render new
    end
  end
end
