class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string  :name, null: false
    end
    add_index :maps, :name
  end
end
