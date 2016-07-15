class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :can_afford, :has_microbe
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_back_or_failsafe(root_path)
    end
  end
  
  def can_afford(microbe)
    true if microbe.cost <= current_user.currency
  end
  
  def has_microbe(microbe)
    true if ((current_user.microbes.to_i & (2 ** (microbe.id.to_i))) == (2 ** (microbe.id.to_i)))
  end
  
  private 
  
    def redirect_back_or_failsafe(user_loc)
      if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
        redirect_to :back #NB deprecated in next version of Rails so we may need to change this when the redirect_back method is implemented!
      else
        redirect_to user_loc
      end
      
    end

end
