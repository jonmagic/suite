class Sentry < ActiveRecord::Base
  has_many :events, :as => :recordable, :dependent => :destroy
  belongs_to :devices
  belongs_to :schedule
  
end
