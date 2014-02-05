module Sinatra
  module YouDaoTranslator

    def translate(query)
      # TODO: filtering query?
      ydclient = YouDaoClient.new
      result = ydclient.search(query)
      result["translation"]
    end

    class Translator
    end

    class YouDaoClient
      include HTTParty
      base_uri 'fanyi.youdao.com'

      def initialize(options = {})
        @options = {
          :query => {
            :keyfrom => "WechatMPTranslator",
            :key => "308122013",
            :type => "data",
            :doctype => "json",
            :version => "1.1"
          }
        }.merge(options)
      end

      def search(query)
        @options[:query][:q] = query
        #param = URI.encode_www_form(options)
        self.class.get("/openapi.do", @options)
      end

    end
  end

  helpers YouDaoTranslator
end
