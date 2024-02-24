# frozen_string_literal: true

module Http
  class Native
    def get(url)
      [url] => [URI]

      res = Net::HTTP.get_response(url)

      Response.new(body: res.body, status: res.code)
    end
  end
end
