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

  def assign!(keys, params) = keys.each { |key| send("#{key}=", params[key]) }
end
