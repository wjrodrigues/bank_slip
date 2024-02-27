# frozen_string_literal: true

class ServiceResponse
  attr_accessor :result, :error

  def initialize(result: nil, error: nil)
    self.result = result
    self.error = error
  end

  def ok? = error.nil?

  def add_error(err, translate: false)
    self.error = translate ? I18n.t(err) : err
    self
  end

  def add_result(result)
    self.result = result
    self
  end
end
