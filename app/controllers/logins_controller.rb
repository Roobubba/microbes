class LoginsController < ApplicationController
  
  def new

  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome " + user.username + ", login successful"
      redirect_to microbes_path
    else
      flash.now[:danger] = "Your email address or password does not match"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Logout successful"
    render '/pages/home'
  end

end