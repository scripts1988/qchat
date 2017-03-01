class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def new
    @user = User.new(email: params[:email])
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome to qChat, " + @user.name
      redirect_to root_path
    else
      render 'new'
    end
  end

  def add_friend
    friend_ship = Friendship.new
    friend_ship.user_id = params[:user_id]
    friend_ship.friend_id = params[:friend_id]

    if friend_ship.save!
      flash[:success] = "You added " + User.find_by_id(params[:friend_id]).name + " to friendship" 
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
