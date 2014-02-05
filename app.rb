require 'sinatra'
require 'sinatra/reloader' if development?

TOKEN = 'dxhackers'

module Sinatra
  module Devise
    def authorize!
      nonce, timestamp, signature = params[:nonce], params[:timestamp], params[:signature]
      if [nonce, timestamp, signature].compact.size < 3 or signature != genarate_signature(TOKEN, nonce, timestamp)
        logger.info "FAILED"
        halt 401, "Forbidden! You Bastards!"
      end
    end

    private
    def genarate_signature(token, nonce, timestamp)
      Digest::SHA1.hexdigest([token, nonce, timestamp].sort.join)
    end
  end

  register Devise
end

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

  authorize!

  logger.info "PASSED"
  200
  # TODO: send something back
end
