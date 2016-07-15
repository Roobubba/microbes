class Microbe < ActiveRecord::Base

  validates :name, presence: true, length: {minimum: 3, maximum: 40 }
  validates :link, presence: true, length: {minimum: 10, maximum: 150 }
  validates :cost, presence: true
  validates :fullname, presence: true, length: {minimum: 3, maximum: 60 }

end