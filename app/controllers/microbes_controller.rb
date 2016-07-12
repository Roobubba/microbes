class MicrobesController < ApplicationController
  
  before_action :set_microbe, only: [:edit, :update, :show, :export]
  before_action :require_user, except: [:show, :index, :export]
  before_action :admin_user, only: [:destroy, :create, :new]
  
  
  def index
    @microbes = Microbe.paginate(page: params[:page], per_page: 4)
  end
  
  def show
    
  end
  
  def new
    @microbe = Microbe.new
  end
  
  def create
    @microbe = Microbe.new(microbe_params)
    
    if @microbe.save
      flash[:success] = "New microbe created successfully"
      redirect_to microbes_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @microbe.update(microbe_params)
      flash[:success] = "Microbe was updated successfully"
      redirect_to microbe_path(@microbe)
    else
      render 'edit'
    end
  end
  
  
  
  def export
    
    send_data @microbe.link, type: 'text/plain; charset=UTF-8', disposition: 'inline' #attachment; filename=mhash.xml'

  end
  
  private

    def set_microbe
      @microbe = Microbe.find(params[:id])
    end
   
    def admin_user
      redirect_to microbes_path unless current_user.admin?
    end
  
    def microbe_params
      params.require(:microbe).permit(:assetbundle, :assetname, :link, :name)
    end
end