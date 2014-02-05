require 'sinatra'
require 'sinatra/reloader' if development?

#class Application < Sinatra::Base
  #register Sinatra::Reloader

  get '/' do
    "Hello Sinatra!"
  end
#end
