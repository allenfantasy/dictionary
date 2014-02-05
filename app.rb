$:.unshift File.expand_path("../lib", __FILE__)

require 'sinatra'
require 'sinatra/devise'
require 'sinatra/youdao_translator'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'multi_xml'
require 'builder'

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
  req_message = MultiXml.parse(request.body.read)['xml']
  logger.info "REQ: #{req_message}"
  authorize!

  logger.info "PASSED"

  # RESPONSE

  query = req_message["Content"]

  res_message = {
    "ToUserName" => req_message["FromUserName"],
    "FromUserName" => req_message["ToUserName"],
    "CreateTime" => Time.now.to_i, # unix timestamp
    "MsgType" => 'text',
    "Content" => translate(query)
  }.to_xml(:root => 'xml')

end
