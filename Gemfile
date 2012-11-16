source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'logger'
gem 'json'
gem 'rack-cors'
gem 'data_mapper', '1.2.0'
gem 'thin'

group :development, :test do
  gem 'rspec'
  gem 'dm-rspec2'
  gem 'rb-fsevent', :require => false
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'rb-inotify', '~> 0.8.8', :require => false
  gem 'rack-test'
  gem 'dm-sqlite-adapter'
end

group :production do
  gem 'do_postgres'
end
