class Microbe < ActiveRecord::Base

  validates :name, presence: true, length: {minimum: 3, maximum: 40 }
  validates :link, presence: true, length: {minimum: 10, maximum: 150 }
  validates :cost, presence: true
  validates :fullname, presence: true, length: {minimum: 3, maximum: 60 }
  
  mount_uploader :picture, PictureUploader
  validate :picture_size

  mount_uploader :attachment, AttachmentUploader
  
  mount_uploader :androidattachment, AndroidattachmentUploader


  private
    def picture_size
      if picture.size > 2.megabytes
        errors.add(:picture, "should be less than 2MB")
      end
    end
  
end