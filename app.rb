require 'sinatra'
require 'sinatra/reloader' if development?

configure do
  enable :logging
end

get '/' do
  logger.info "------PARAMS------"
  logger.info params
  "Hello Sinatra!"
end
