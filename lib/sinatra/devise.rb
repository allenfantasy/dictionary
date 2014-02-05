require 'sinatra/base'
require 'httparty'

module Sinatra
  module Devise
    TOKEN = 'dxhackers'
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

  helpers Devise
end
