class Thing < ActiveRecord::Base
  belongs_to :attached, :polymorphic => true

  has_attached_file :attachment, :whiny_thumbnails => false
                    
  validates_attachment_presence :attachment
  validates_attachment_size :attachment, :less_than => 200.megabytes, :message => "File is too large."
  
  before_create :assign_name
  
  def assign_name
    self.name.blank? ? self.name = self.attachment_file_name : true
  end
  
end
