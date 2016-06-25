require "msgpack"

# Monkey patch
# class Date
#   def to_msgpack(*a); to_s.to_msgpack(*a) end
# end
# class Time
#   def to_msgpack(*a); to_s.to_msgpack(*a) end
# end
# class DateTime
#   def to_msgpack(*a); to_s.to_msgpack(*a) end
# end

MessagePack::DefaultFactory.register_type(0x01,
                                          Time,
                                          packer: ->(t){ t.to_r.to_s.to_msgpack },
                                          unpacker: ->(t){ Time.at(Rational(MessagePack.unpack(t))) })

MessagePack::DefaultFactory.register_type(0x7f, Date, packer: ->(t){ t.to_s.to_msgpack }, unpacker: ->(d){ Date.parse(MessagePack.unpack(d)) })
MessagePack::DefaultFactory.register_type(0x7f, DateTime, packer: ->(t){ t.to_s.to_msgpack }, unpacker: ->(d){ DateTime.parse(MessagePack.unpack(d)) })


module ActiveRecord
  module Msgpack
    module Model
      extend ActiveSupport::Concern

      def to_msgpack
        MessagePack.pack([self.class.name, self.attributes])
      end
    end
  end
end
