# frozen_string_literal: true

# From https://github.com/midori-rb/midori.rb/blob/master/lib/midori/core_ext/configurable.rb

module Configurable
  # Sets an option to the given value.
  # @param [Symbol] option the name of config
  # @param [Object] value value to the name
  # @param [Boolean] read_only Generate option= method or not
  # @return [nil] nil
  def set(option, value = (not_set = true), read_only: false)
    raise ArgumentError if not_set

    setter = proc { |val| set option, val }
    getter = proc { value }

    define_singleton("#{option}=", setter) unless read_only
    define_singleton(option, getter)
    define_singleton("#{option}?", "!!#{option}") unless method_defined? "#{option}?"

    self
  end

  private

  # Dynamically defines a method on settings.
  # @param [String] name method name
  # @param [Proc] content method content
  # @return [nil] nil
  def define_singleton(name, content = Proc.new)
    singleton_class.class_eval do
      undef_method(name) if method_defined? name
      if content.is_a?(String)
        # rubocop:disable Style/DocumentDynamicEvalDefinition
        class_eval("def #{name}() #{content}; end", __FILE__, __LINE__)
        # rubocop:enable Style/DocumentDynamicEvalDefinition
      else
        define_method(name, &content)
      end
    end
  end
end
