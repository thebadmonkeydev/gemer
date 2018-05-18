module Gemer
  module Configurable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def setup_config
        config = Gemer::Configurator.new(self)
        config.define_configuration_error

        yield config
      end

      def configure
        yield self
      end
    end
  end
end
