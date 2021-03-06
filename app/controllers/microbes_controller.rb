class MicrobesController < ApplicationController
  
  before_action :set_microbe, only: [:edit, :update, :show, :buy]
  before_action :set_user, only: [:buy]
  before_action :require_user, except: [:show, :index]
  before_action :admin_user, only: [:destroy, :create, :new, :edit, :update]
  
  
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
  
  def buy
    if has_microbe(@microbe)
      flash[:warning] = "Already own microbe"
      redirect_to microbe_path(@microbe)
      return
    end
    if !can_afford(@microbe)
      flash[:warning] = "Cannot afford microbe"
      redirect_to microbe_path(@microbe)
      return
    end
    new_currency = @user.currency - @microbe.cost
    new_microbes = @user.microbes + (2 ** (@microbe.id))
    if @user.update(currency: new_currency, microbes: new_microbes)
      flash[:success] = "Microbe successfully purchased"
    else
      flash[:warning] = "Error: could not purchase microbe!"
    end
      redirect_to microbe_path(@microbe)
  end
  

  private

    def set_microbe
      @microbe = Microbe.find(params[:id])
    end
    
    def set_user
      @user = current_user        
    end
    
    def admin_user
      redirect_to microbes_path unless current_user.admin?
    end
  
    def microbe_params
      params.require(:microbe).permit(:cost, :link, :name, :fullname, :morphology_id, :gram_status, :dimensions, :number_genes, :pathogenic, :picture, :attachment, :androidattachment, :remove_picture, :remove_attachment, :remove_androidattachment)
    end
    
end