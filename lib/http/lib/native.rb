# frozen_string_literal: true

module Http
  module Lib
    class Native
      HEADER = {
        json: { 'Content-Type': 'application/json' }
      }.freeze

      def get(url, header: {})
        [url] => [URI]

        res = Net::HTTP.get_response(url, header)

        Response.new(body: res.body, status: res.code)
      end

      def post(url, payload: {}, header: HEADER[:json])
        [url, payload, header] => [URI, Hash, Hash]

        res = Net::HTTP.post(url, payload.to_json, header)

        Response.new(body: res.body, status: res.code)
      end

      def put(url, payload: {}, header: HEADER[:json])
        [url, payload, header] => [URI, Hash, Hash]

        req = Net::HTTP::Put.new(url)

        req.body = payload.to_json

        header.each_key { |key| req[key] = header[key] }

        res = Net::HTTP.start(url.hostname) { |http| http.request(req) }

        Response.new(body: res.body, status: res.code)
      end
    end
  end
end
