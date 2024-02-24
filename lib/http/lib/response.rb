# frozen_string_literal: true

module Http
  module Lib
    class Response
      attr_accessor :body, :status

      private :body=, :status=

      def initialize(body:, status: '')
        [body, status] => [String, String]

        self.body = body
        self.status = status
      end

      def json! = JSON.parse(body)

      def raw = body
    end
  end
end
