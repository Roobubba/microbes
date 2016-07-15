class MorphologiesController < ApplicationController
  
  before_action :set_morphology, only: [:edit, :update, :show]
  before_action :require_user, except: [:show, :index]
  before_action :admin_user, only: [:destroy, :create, :new]
  
  def index
    @morphologies = Morphology.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    
  end
  
  def new
    @morphology = Morphology.new
  end
  
  def create
    @morphology = Morphology.new(morphology_params)
    
    if @morphology.save
      flash[:success] = "New morphology created successfully"
      redirect_to morphology_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @morphology.update(morphology_params)
      flash[:success] = "Morphology was updated successfully"
      redirect_to morphology_path(morphology)
    else
      render 'edit'
    end
  end
  

  private

    def set_morphology
      @morphology = Morphology.find(params[:id])
    end
    
    def admin_user
      redirect_to morphology_path unless current_user.admin?
    end
  
    def morphology_params
      params.require(:morphology).permit(:morphology)
    end
    
end