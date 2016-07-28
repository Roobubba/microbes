class User < ActiveRecord::Base

  before_save :default_values
  def default_values
    self.email = email.downcase
    self.microbes ||= 7
    self.currency ||= 2000
  end

  validates :username, length: {minimum: 3, maximum: 40 }
  validates :uniqueid, presence: true, uniqueness: true
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 105 },
                                    uniqueness: { case_sensitive: false },
                                    format: {with: VALID_EMAIL_REGEX }
  
  has_secure_password         

end