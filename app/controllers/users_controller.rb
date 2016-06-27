class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :export_to_txt]
  before_action :require_user, except: [:show, :index, :export_to_txt, :get_user_id]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
  
  end
  
  def export_to_txt
    
    send_data @user.microbes, type: 'text/plain; charset=UTF-8', disposition: 'attachment; filename=mlist.txt'
    
  end
  
  def get_user_id
    @user = User.find_by(uniqueid: params[:uniqueid])
  end


  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def admin_user
    redirect_to users_path unless current_user.admin?
  end
  
end
