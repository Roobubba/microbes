class PagesController < ApplicationController
  
  def home
    redirect_to microbes_path if logged_in?
  end
  
end