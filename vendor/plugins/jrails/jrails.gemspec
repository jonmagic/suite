Gem::Specification.new do |s|
  s.name = "jrails"
  s.version = "0.3.20080507"
  s.date = "2008-05-07"
  s.summary = "Gemified jRails plugin"
  s.email = "avanie@gmail.com"
  s.homepage = "http://github.com/pager/jrails"
  s.has_rdoc = true
  s.authors = ["aaronchi@gmail.com"]
  s.files = [
    "CHANGELOG",
    "install.rb",
    "javascripts/jquery-fx.js",
    "javascripts/jquery-ui.js",
    "javascripts/jquery.js",
    "javascripts/jrails.js",
    "javascripts/sources/jquery-fx.js",
    "javascripts/sources/jquery-ui.js",
    "javascripts/sources/jrails.js",
    "lib/jrails.rb",
    "rails/init.rb",
    "README",
    "README.GEM",
    "tasks/jrails.rake",

  ]
  s.rdoc_options = ["--main", "README.GEM", "README" ]
  s.extra_rdoc_files = ["README", "README.GEM", "CHANGELOG"]
end
