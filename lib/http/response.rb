# frozen_string_literal: true

module Http
  class Response
    attr_accessor :body, :status

    private :body=, :status=

    def initialize(body:, status: 0)
      [body, status] => [String, String]

      self.body = body
      self.status = status
    end

    def json! = JSON.parse(body)

    def raw = body
  end
end
