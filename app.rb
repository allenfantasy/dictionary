$:.unshift File.expand_path("../lib", __FILE__)

require 'sinatra'
require 'sinatra/devise'
require 'sinatra/reloader' if development?
require 'multi_xml'

configure do
  enable :logging
end

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
  logger.info "------BODY------"
  #logger.info "REQUEST CLASS: #{request.class}" # Sinatra::Request < Rack::Request
  #logger.info "BODY: #{request.body}" # StringIO < Data < Object
  #logger.info "BODY.READ: #{request.body.read}" # String
  logger.info "HASH: #{hash = MultiXml.parse(xml)['xml']}"
  authorize!

  logger.info "PASSED"
  200
  # TODO: send something back
end
