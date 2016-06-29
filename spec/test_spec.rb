$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "spec_helper"

describe "Test" do

  it "hello" do
    alice = User.create(name: "alice")

    dump = ActiveRecord::Msgpack::Serializer.dump(alice)
    after_alice = ActiveRecord::Msgpack::Serializer.load(dump)

    expect(after_alice.id).to eq alice.id
    expect(after_alice.name).to eq alice.name
    expect(after_alice.created_at.to_s).to eq alice.created_at.to_s
    expect(after_alice.updated_at.to_s).to eq alice.updated_at.to_s
  end

  it "Pack/Unpack Time class include milliseconds" do
    now = Time.now
    packed = MessagePack.pack(now)
    unpacked_time = MessagePack.unpack(packed)

    expect(unpacked_time.to_i).to eq now.to_i
    expect(unpacked_time.nsec).to eq now.nsec
    expect(unpacked_time).to eq now
  end

  it "Pack/Unpack Date class" do
    date = Date.new
    packed = MessagePack.pack(date)
    unpacked_date = MessagePack.unpack(packed)
    expect(unpacked_date).to eq date
  end
end
