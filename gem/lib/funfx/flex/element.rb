module FunFX
  module Flex
    
    # Base class for all Flex proxy elements
    class Element
      def initialize(flex_app, locator_hash)
        @flex_app = flex_app
        @id = locator_hash.map do |key, value|
          "#{key}{#{value} string}"
        end.join
        puts "ID: #{@id}"
      end

      # Fires and
      def fire_event(event_name, *args)
        flex_args = args.join("_ARG_SEP_")
        puts "FLEX_ARGS: #{flex_args}"
        @flex_app.fire_event("|#{@id}", event_name, flex_args)
      end
      
      def get_property_value(property, type)
        raw_value = @flex_app.get_property_value("|#{@id}", property)
        if raw_value =~ /^____ERROR_FIELD_NOT_FOUND:(.*)/
          raise "Could not find field #{property}: #{$1}"
        end
        value = case(type)
        when :string
          raw_value
        when :number
        when :int
          raw_value.to_i
        when :boolean
          raw_value == "true"
        when :enumeration
          [raw_value]
        else
          raise "I don't know how to convert to #{type}"
        end
        value
      end
    end
  end
end