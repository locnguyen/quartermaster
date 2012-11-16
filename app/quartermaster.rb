require 'sinatra'
require 'trinidad'

class Quartermaster < Sinatra::Base
  get '/' do
    "Hello world!"
  end
end