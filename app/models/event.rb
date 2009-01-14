class Event < ActiveRecord::Base
  belongs_to :recordable, :polymorphic => true
  
  def has(word)
    self.message =~ /#{word}/ ? true : false
  end
  alias :have :has
  
  def to_time
    if !self.message.blank?
      self.message.to_time
    else
      ""
    end
  end
  
  def message
    self.data
  end
  
end