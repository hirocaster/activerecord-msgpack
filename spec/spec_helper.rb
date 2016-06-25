require "pry"
require "active_record"
require "activerecord-msgpack"

require File.expand_path('../models', __FILE__)

ActiveRecord::Base.default_timezone = :local

include ActiveRecord::Tasks

DatabaseTasks.db_dir = File.expand_path('..', __FILE__)
ActiveRecord::Tasks::DatabaseTasks.root = File.expand_path('../..', __FILE__)
DatabaseTasks.env = 'test'
DatabaseTasks.database_configuration = ActiveRecord::Base.configurations

args = ActiveRecord::Base.configurations

DatabaseTasks.drop(args['test'])
DatabaseTasks.create(args['test'])
DatabaseTasks.load_schema(:ruby)

# RSpec.configure do |config|
#   config.before(:suite) do
#     DatabaseTasks.db_dir = File.expand_path('..', __FILE__)
#     DatabaseTasks.drop("test")
#     DatabaseTasks.create("test")
#     DatabaseTasks.load_schema("test")
#   end
# end
