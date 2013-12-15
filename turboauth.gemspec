Gem::Specification.new do |s|
  s.name        = 'turboauth'
  s.version     = '0.0.6'
  s.executables << 'turboauth'
  s.date        = '2013-12-12'
  s.summary     = "A gem for speedy auth setup in new Rails apps."
  s.description = "A gem to run after creating a new rails app to setup basic authentication via oauth with the least effort possible on the part of the user."
  s.authors     = ["Sam Owens"]
  s.email       = 'samueldowens@gmail.com'
  s.files       =  Dir["{bin,lib}/*"]
  s.homepage    =  'http://rubygems.org/gems/turboauth'
  s.license     = 'MIT'
end