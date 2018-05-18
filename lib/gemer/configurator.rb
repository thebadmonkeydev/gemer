module Gemer
  class Configurator
    def initialize(target)
      @target = target
    end

    def define_configuration_error
      @target.class_eval <<-DEF, __FILE__, __LINE__ + 1
        class ConfigError < StandardError; end
      DEF
    end

    def attr(name, default = nil, **opts)
      define_reader name
      define_writer name
      set_default name, default
      set_options name, opts
    end

    def read_only(name, value)
      define_reader name
      @target.class_eval do
        instance_variable_set("@#{name}".to_sym, value)
      end
    end

    def set_options(name, opts = {})
      set_in(name, opts[:in]) if opts[:in]
    end

    def set_in(name, values)
      @target.class_eval <<-DEF, __FILE__, __LINE__ + 1
          class << self
            def #{name}=(obj)
              raise 'value for #{@target.name}.#{name} is invalid, must be one of #{values}' unless #{values}.include?(obj)
              @#{name} = obj
            end
          end
      DEF
    end

    def set_default(name, value)
      @target.class_eval <<-DEF, __FILE__, __LINE__ + 1
          class << self
            def #{name}
              @#{name} ||= #{interpolated_value(value)}
            end
          end
      DEF
    end

    def interpolated_value(value)
      case value.class.name
      when 'NilClass'
        'nil'
      when 'String'
        "'#{value}'"
      else
        value
      end
    end

    def define_reader(name)
      @target.class_eval <<-DEF, __FILE__, __LINE__ + 1
          class << self
            attr_reader :#{name}
          end
      DEF
    end

    def define_writer(name)
      @target.class_eval <<-DEF, __FILE__, __LINE__ + 1
          class << self
            attr_writer :#{name}
          end
      DEF
    end
  end
end
