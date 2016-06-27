class User < ActiveRecord::Base
  
  validates :username, presence: true;
  validates :uniqueid, presence: true;
  
end