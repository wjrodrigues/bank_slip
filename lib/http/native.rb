# frozen_string_literal: true

module Http
  class Native
    HEADER = {
      json: { 'Content-Type': 'application/json' }
    }.freeze

    def get(url)
      [url] => [URI]

      res = Net::HTTP.get_response(url)

      Response.new(body: res.body, status: res.code)
    end

    def post(url, params: {}, header: HEADER[:json])
      [url, params, header] => [URI, Hash, Hash]

      res = Net::HTTP.post(url, {}.to_json, header)

      Response.new(body: res.body, status: res.code)
    end
  end
end
