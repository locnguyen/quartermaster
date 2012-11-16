require 'sinatra/base'

class Quartermaster < Sinatra::Base
  get '/' do
    "Hello world!"
  end

  run!
end