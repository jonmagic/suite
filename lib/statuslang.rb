require 'statuslang/lang'
module StatusLang
  def self.run(sentry_id,code)
    Lang.new(sentry_id).instance_eval(code)
  end
end
