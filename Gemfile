source 'https://rubygems.org'

gem 'sinatra'
# sinatra-contrib messes with the global namespace,
# require: false lets Rake tasks run properly
gem 'sinatra-contrib', require: false
gem 'sinatra-initializers'

# web server and runner
gem 'foreman'
gem 'thin'

# common gems
gem 'json'
gem 'activesupport'
gem 'i18n'

# exception handling and monitoring
gem 'newrelic_rpm'
gem 'rollbar'

# API utils
gem 'rack-parser'
gem 'rack-cors'

# DB access
gem 'riak-client'

group :development, :test do
  gem 'guard-rspec'
  gem 'pry-byebug'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec-its'
  gem 'json_spec'

  # code coverage
  gem 'simplecov',                 require: false
  gem 'codeclimate-test-reporter', require: false
end
