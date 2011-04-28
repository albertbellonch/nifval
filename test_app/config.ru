if ENV['HEROKU'].present?
  WEBSITE_SUBDIR = "test_app"
  require "#{WEBSITE_SUBDIR}/config/environment"
else
  require ::File.expand_path('../config/environment',  __FILE__)
end
run TestApp::Application
