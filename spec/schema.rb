ActiveRecord::Schema.define(version: 0) do
  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.timestamps null: false
  end
end
