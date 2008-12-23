require 'simple_mapper'
require 'net/http'
require 'lib/nethttp_magic'

module StatusLang
  # Post is a String class that is also a SimpleMapper persistence class reading from StatusPing.com.
  # The reason it is also a string is so that it can be treated as a simple string of the Message content itself if desired.
  # 
  # To use, first set the options (which will be set per-feed)
  #   StatusLang::Post.options(:feed_key => feed_key, :feed_secret => feed_secret)
  # then call just like any SimpleMapper model: Post.get(..query-params..).
  class Message < String
    include SimpleMapper::Persistence
    set_format :json
    set_entity_name 'message'
    add_connection_adapter(:http) do
      set_base_url 'http://statusping.com/messages'
    end
    has :properties
      property :feed
      property :created_by
      property :content
      property :created_at
    uses :callbacks
      add_callback('initialize_request') do |request,cboptions|
        # Add HTTP Basic Auth to the request
        # the nonce can technically be anything, but to be best secure we want it pretty randomly generated.
        nonce = Digest::SHA1.hexdigest("--#{rand(1234)}--#{Time.now.to_s}--#{rand(12345)}--")
        sequence = Time.now.to_f
        request.add_query_param(:nonce => nonce)
        request.basic_auth options[:feed_key], Digest::SHA1.hexdigest("#{nonce}#{options[:feed_secret]}")
        [request,cboptions]
      end
    def self.options(options=nil)
      Thread.current['statusping_options'] = options if options
      Thread.current['statusping_options'] ||= {}
    end

    # Sets the data into the object. This is provided as a default method, but your model can overwrite it any
    # way you want. For example, you could set the data to some other object type, or to a Marshalled storage.
    # The type of data you receive will depend on the format and parser you use. Of course you could make up
    # your own spin-off of one of those, too.
    def data=(data)
      raise TypeError, "data must be a hash" unless data.is_a?(Hash)
      data.each {|k,v| instance_variable_set("@#{k}", v)}
      self.replace(@content)
    end
    alias :update_data :data=


    # The following is for StatusLang.

    attr_accessor :any_all

    def has(word)
      self =~ /#{word}/ ? true : false
    end
    alias :have :has
  end
end
