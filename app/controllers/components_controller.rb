class ComponentsController < ApplicationController
  
  def new
    @component = Component.new
  end
  
  def create
    if @component.save
      flash[:notice] = 'Client was successfully created.'
    end
  end
  
  def edit
  end
  
  def update
  end
  
end
