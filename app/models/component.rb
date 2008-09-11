class Component < ActiveRecord::Base
  belongs_to :device
  
  after_save :log
  
  protected

    def log
      
    end
  
end
