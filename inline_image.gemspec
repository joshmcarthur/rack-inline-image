Gem::Specification.new do |s|
  s.name        = "inline_image"
  s.version     = 0.1
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josh McArthur"]
  s.email       = ["joshua.mcarthur@gmail.com"]
  s.homepage    = "http://github.com/joshmcarthur/rack-inline-image/"
  s.summary     = "Dynamically embed images into your application to reduce requests and speed things up!"
  s.description = "Framework-agnostic Rack middleware to reduce overall load time by injecting image file contents directly into the image tag"
 
  s.required_rubygems_version = ">= 1.3.6"
 
 
  s.files        = Dir.glob("{lib}/**/*") + %w(README.md)
  s.require_path = 'lib'
end
