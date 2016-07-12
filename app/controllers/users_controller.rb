class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_user, except: [:show, :index, :export, :get_user_id]
  before_action :admin_user, only: [:destroy]
  

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "Your profile was created successfully"
      session[:user_id] = @user.id
      redirect_to microbes_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your profile was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def get_user_id
    @user = User.find_by(uniqueid: params[:uniqueid])
    #if @user.logged_in?
      send_data @user.microbes, type: 'text/plain; charset=UTF-8', disposition: 'inline'
    #end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :uniqueid, :email, :password, :password_confirmation, :microbes)
  end

  def set_user
    @user = User.find(params[:id])
  end
  
  def admin_user
    redirect_to users_path unless current_user.admin?
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your own profile"
      redirect_to root_path
    end
  end

end
