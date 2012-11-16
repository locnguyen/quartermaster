source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'logger'
gem 'json'
gem 'rack-cors'
gem 'data_mapper'
gem 'do_jdbc'


gem 'trinidad', :require => nil

group :development, :test do
  gem 'rspec'
  gem 'dm-rspec2'
  gem 'rb-fsevent', :require => false
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'rb-inotify', '~> 0.8.8', :require => false
  gem 'rack-test'
  gem 'do_sqlite3'
  gem 'dm-sqlite-adapter'
end

group :production do
  gem 'do_postgres'
end
