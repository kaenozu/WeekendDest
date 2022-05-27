require 'net/https'
require 'uri'
require 'json'

# 最終的に　https://www.geocoding.jp/api/　を使うかも

module Api
  module GoogleGeo
    class Request
      attr_accessor :query

      def request(param)
        uri = URI.parse('https://script.google.com/macros/s/AKfycbytzsMF7hCN7yab9fhuQCZUzOSMSGkI3Q9bXTIerROkrVCqdeS8byvTNFDLiM77o6fO/exec?' + URI.encode_www_form(src: param))
        res = Net::HTTP.get_response(uri)

        if res.code == '302'
          res = Net::HTTP.get_response(URI.parse(res.header['location']))
          result = JSON.parse(res.body)
        end
      end
    end
  end
end
