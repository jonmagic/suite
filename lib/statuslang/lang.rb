require 'statuslang/ruby_lang_extensions'
module StatusLang
  class Lang
    def initialize(sentry_id)
      @sentry_id = sentry_id
    end
    
    def last(amount=nil)
      if amount
        if amount.is_a?(Duration)
          options[:after] = amount.ago
        elsif amount.is_a?(Integer)
          options[:limit] = amount
        else
          raise ArgumentError, "amount must be a Duration or an Integer!"
        end
      end
      self
    end

    def posts
      if @options[:after]
        Event.find(:all, :conditions => {:recordable_type => "Sentry", :recordable_id => @sentry_id, :created_at.gte => @options[:after] + 4.hours})
      elsif @options[:limit]
        Event.find(:all, :conditions => {:recordable_type => "Sentry", :recordable_id => @sentry_id}, :limit => @options[:limit])
      end
    end
    def post
      Event.find(:last, :conditions => {:recordable_type => "Sentry", :recordable_id => @sentry_id})
    end
    def all_posts
      posts.all
    end
    def any_post
      posts.any
    end

    private
      def options
        @options ||= {}
      end
  end
end
