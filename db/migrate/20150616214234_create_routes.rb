class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes, force: true, id: false do |t|
      t.integer  :to_id, null: false
      t.integer  :from_id, null: false
      t.integer  :distance, null: false
    end
    add_index :routes, :to_id
    add_index :routes, :from_id
    add_index :routes, [:to_id, :from_id]
  end
end
