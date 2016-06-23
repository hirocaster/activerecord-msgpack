module ActiveRecord
  module Msgpack
    module Serializer

        def self.dump(value)
          if value.class.ancestors.include?(ActiveRecord::Msgpack::Model)
            value.to_msgpack
          end
        end

        def self.load(value)
          unpack = MessagePack.unpack(value)
          if unpack.kind_of?(Array)
            if const_defined?(unpack[0]) && const_get(unpack[0]).ancestors.include?(ActiveRecord::Msgpack::Model)

              klass = const_get(unpack[0])
              attributes = unpack[1]

              if ::ActiveRecord::VERSION::STRING < '4.2.0'
                klass.serialized_attributes.each do |k, v|
                  next if attributes[k].nil? || attributes[k].is_a?(String)
                  attributes[k] = attributes[k].serialized_value if attributes[k].respond_to?(:unserialize)
                end
              else
                klass.columns.select{|t| t.cast_type.is_a?(::ActiveRecord::Type::Serialized) }.each do |c|
                  name, coder = c.name, c.cast_type.coder
                  next if attributes[name].nil? || attributes[name].is_a?(String)
                  attributes[name] = coder.dump(attributes[name]) if attributes[name].is_a?(coder.object_class)
                end
              end

              klass.instantiate(attributes)
            else
              unpack
            end
          end
        end

    end
  end
end
