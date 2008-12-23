class Array
  def not_empty
    !empty?
  end

  def all
    @any_all = :all
    self
  end
  def any
    @any_all = :any
    self
  end

  # Very special magic! If you have an array of objects, you can call a method on the array and it will be passed to each element, IF all elements respond to that method.
  def method_missing(sym, *args)
    # If all elements respond to the method, call it on each of them and return an array of the results.
    if self.all? {|e| e.respond_to?(sym)}
      if @any_all
        if @any_all == :all
          return self.all? {|e| e.send(sym, *args)}
        elsif @any_all == :any
          return self.any? {|e| e.send(sym, *args)}
        else
          raise "@any_all must be only :any or :all"
        end
      else
        return self.collect {|e| e.send(sym, *args)}
      end
    end
    # To force calling the method even if method_missing doesn't show they all work, or otherwise just for readability, use this instead:
    # [].collect_somethings == [].collect(&:something)
    return self.collect {|e| e.send(Inflector.singularize(sym.to_s.match(/^collect_(.*)/)[1]).to_sym, *args)} if sym.to_s =~ /^collect_(.*)/
    super
  end

  alias :count :length
end
