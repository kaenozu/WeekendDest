require "net/https"
require "uri"
require "json"

module Api
  module GoogleRoute
    class Request
      p "API Start"
      attr_accessor :query

      def request(route)
        uri = URI.parse("https://script.google.com/macros/s/AKfycbyPvT1K338SNJT_NdqZrqYCw-UxMXOKboW6wM3X8aTIw1bFwNi0Ks8K1jpikrVRfgKC/exec")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme === "https"

        params = { routes: route }
        headers = { "Content-Type" => "application/json" }

        res = http.post(uri.path, params.to_json, headers)

        # params = URI.encode_www_form({ src: src, dest: dest })

        # uri = URI.parse('https://script.google.com/macros/s/AKfycbwOVHkgaoegqoblTc0bmuuQbQCJRMjKEpD9fU3EVkt7rxaQ4XFAbOwtjgAo7tT82lSxbw/exec?#{params}')
        # res = Net::HTTP.get_response(uri)

        if res.code == "302"
          res = Net::HTTP.get_response(URI.parse(res.header["location"]))
          p "after 302 res.body:" + res.body
          result = JSON.parse(res.body)
        end
      end
    end
  end
end
