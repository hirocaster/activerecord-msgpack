require "msgpack"

MessagePack::DefaultFactory.register_type(0x01,
                                          Time,
                                          packer: ->(t){ t.to_r.to_s.to_msgpack },
                                          unpacker: ->(t){ Time.at(Rational(MessagePack.unpack(t))) })

MessagePack::DefaultFactory.register_type(0x02,
                                          Date,
                                          packer: ->(t){ t.to_s.to_msgpack },
                                          unpacker: ->(d){ Date.parse(MessagePack.unpack(d)) })

MessagePack::DefaultFactory.register_type(0x03,
                                          DateTime,
                                          packer: ->(dt){ dt.to_time.to_r.to_s.to_msgpack },
                                          unpacker: ->(dt){ Time.at(Rational(MessagePack.unpack(dt))).to_datetime })

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
