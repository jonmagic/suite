class Event < ActiveRecord::Base
  belongs_to :recordable, :polymorphic => true
  
  def has(word)
    self.message =~ /#{word}/ ? true : false
  end
  alias :have :has
  
  def message
    self.data
  end
  
end