require 'sinatra'
require 'sinatra/reloader' if development?
require './helpers'

TOKEN = 'dxhackers'

configure do
  enable :logging
end

helpers ApplicationHelper

get '/' do
  logger.info "------GET HOME------"
  logger.info params
  "Hello Sinatra!"
end

get '/wechat' do
  logger.info "------VERIFY------"
  logger.info params
  params["echostr"]
end

post '/wechat' do
  logger.info "------POST------"
  logger.info params
  if authenticated?
    # reply logic
  else
    # forbidden logic
  end
end
