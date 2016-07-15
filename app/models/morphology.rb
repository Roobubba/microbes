class Morphology < ActiveRecord::Base

  validates :morphology, presence: true, length: {minimum: 3, maximum: 40 }

end