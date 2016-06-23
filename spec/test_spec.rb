$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "spec_helper"

describe "Test" do

  it "hello" do
    alice = User.create(name: "alice")

    dump = ActiveRecord::Msgpack::Serializer.dump(alice)
    after_alice = ActiveRecord::Msgpack::Serializer.load(dump)

    binding.pry

    expect(after_alice.id).to eq alice.id
    expect(after_alice.name).to eq alice.name
    expect(after_alice.created_at.to_s).to eq alice.created_at.to_s
    expect(after_alice.updated_at.to_s).to eq alice.updated_at.to_s
  end
end
