require 'gemer/version'
require 'gemer/configurable'
require 'gemer/configurator'
require 'pry'

module Gemer
  include Gemer::Configurable

  setup_config do |c|
    c.attr :cache
    c.attr :expiry, 5400
    c.attr :force, false, in: [true, false]
    c.attr :logger
    c.attr :prefix

    c.read_only :namespace, 'GraphQL::Cache'
  end
end
