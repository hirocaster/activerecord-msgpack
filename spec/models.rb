base = { "adapter" => "mysql2", "database" => "activerecord-msgpack", "pool" => 5, "timeout" => 5000 }

ActiveRecord::Base.configurations = {
                                     "test" => base
                                    }

ActiveRecord::Base.establish_connection(:test)

class User < ActiveRecord::Base
  include ActiveRecord::Msgpack::Model
end
