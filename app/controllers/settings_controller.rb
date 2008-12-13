class SettingsController < ApplicationController
  before_filter :login_required
  layout 'settings'

  def index
    
  end

end