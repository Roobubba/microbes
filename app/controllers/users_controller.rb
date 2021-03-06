class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :show, :new, :create]
  before_action :require_user, except: [:index, :export, :get_user_id, :new, :create]
  before_action :admin_user, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    microbe_array = Array.new
    $i = 0
    redirect_to(users_path) and return if @user.microbes == nil
    while (2**($i)) <= @user.microbes do
      if has_microbe(Microbe.find_by(id: $i))
        microbe_array.push Microbe.find_by(id: $i)
      end
      $i += 1
    end
    @microbes = WillPaginate::Collection.create(1, 10, microbe_array.length) do |pager|
      pager.replace(microbe_array)
    end
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
    if @user == nil
      send_data 'register', type: 'text/plain; charset=UTF-8', disposition: 'inline'
      #Send specific request for app to create an account - need WWWForm
    else
    #if @user.logged_in?
      send_data @user.microbes, type: 'text/plain; charset=UTF-8', disposition: 'inline'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :uniqueid, :email, :password, :password_confirmation, :microbes, :currency, :platform)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def admin_user
    redirect_to users_path unless current_user.admin?
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only view/edit your own profile"
      redirect_to root_path
    end
  end

end
