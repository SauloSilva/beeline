class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :map
      t.string  :name, null: false
    end
    add_index :cities, :name
    add_index :cities, :map_id
  end
end
