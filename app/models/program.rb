class Program < ActiveRecord::Base
  belongs_to :device
  
  before_save :log
  
  protected

    def log

    end
  
end
