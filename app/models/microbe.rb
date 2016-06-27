class Microbe < ActiveRecord::Base
  
  validates :name, presence: true;
  
end