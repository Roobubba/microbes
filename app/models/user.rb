class User < ActiveRecord::Base

  before_save :default_values
  def default_values
    #self.email = email.downcase
    self.microbes ||= 7
    self.currency ||= 2000
  end

  #validates :username, length: {minimum: 3, maximum: 40 }
  validates :uniqueid, presence: true, uniqueness: true
  #VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  #validates :email, length: { maximum: 105 },
  #                                  uniqueness: { case_sensitive: false },
  #                                  format: {with: VALID_EMAIL_REGEX }
  
  #has_secure_password         



  #class << self
  #  def from_omniauth(auth_hash)
  #    user = find_or_create_by(uniqueid: auth_hash['uid'])
  #    user.username = auth_hash['info']['name']
      #user.location = auth_hash['info']['location']
      #user.image_url = auth_hash['info']['image']
      #user.url = auth_hash['info']['urls'][user.provider.capitalize]
  #    user.save!
  #    user
  #  end
  #end

end