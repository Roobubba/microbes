class Microbe < ActiveRecord::Base

  
  require 'digest/md5'

  before_save :perform_fingerprinting
  
  #REALLY don't like this here. Want to get the proper URL from S3 for the file read if it has already been uploaded.
  def perform_fingerprinting
    self.attachment_fingerprint = Digest::MD5.hexdigest(File.read(self.attachment.path)) if self.attachment_fingerprint == ""
    self.androidattachment_fingerprint = Digest::MD5.hexdigest(File.read(self.androidattachment.path)) if self.androidattachment_fingerprint == ""
    self.link = File.basename(self.androidattachment.path) if self.link == ""
  end

  validates :name, presence: true, length: {minimum: 3, maximum: 40 }
  #validates :link, presence: true, length: {minimum: 10, maximum: 150 }
  validates :cost, presence: true
  validates :fullname, presence: true, length: {minimum: 3, maximum: 60 }
  validates :attachment, presence: true
  validates :androidattachment, presence: true
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