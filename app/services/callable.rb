# frozen_string_literal: true

class Callable
  attr_accessor :response

  private_class_method :new

  def self.call(...)
    new(...).call
  end

  def initialize(...)
    self.response = ServiceResponse.new
  end
end
