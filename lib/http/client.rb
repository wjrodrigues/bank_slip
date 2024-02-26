# frozen_string_literal: true

module Http
  class Client
    PARSE_URL = ->(url) { URI(url) }

    def self.get(url, client: Lib::Native, header: {})
      resp = client.new.get(PARSE_URL[url], header:)

      [resp] => [Http::Lib::Response]

      resp
    end

    def self.post(url, client: Lib::Native, payload: {}, header: {})
      resp = client.new.post(PARSE_URL[url], payload:, header:)

      [resp] => [Http::Lib::Response]

      resp
    end
  end
end
