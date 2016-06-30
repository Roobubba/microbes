class MicrobesController < ApplicationController
  
  before_action :set_microbe, only: [:edit, :update, :show, :export]
  before_action :require_user, except: [:show, :index, :export]
  before_action :admin_user, only: :destroy
  
  
  def index
    @microbes = Microbe.paginate(page: params[:page], per_page: 4)
  end
  
  def show
    
  end
  
  
  def export
    
    send_data @microbe.link, type: 'text/plain; charset=UTF-8', disposition: 'inline' #attachment; filename=mhash.xml'
    #send_data @microbe.to_xml, type: 'text/plain; charset=UTF-8', disposition: 'attachment; filename=mhash.xml'
    
  end
  
  private

    def set_microbe
      @microbe = Microbe.find(params[:id])
    end
   
    def admin_user
      redirect_to microbes_path unless current_user.admin?
    end
  
end