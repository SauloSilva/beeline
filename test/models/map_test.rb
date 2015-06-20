require 'test_helper'

class MapTest < ActiveSupport::TestCase
  test 'should not save map without name' do
    map = Map.new
    assert_not map.save
  end

  test 'should not save map with same name with same map' do
    map = Map.new(name: 'sp')
    assert_not map.save
  end

  test 'should delete all cities dependent' do
    city_count = City.count
    Map.first.destroy

    assert_not_equal city_count, City.count
  end

  test 'should upcase name' do
    map = Map.create(name: 'foo')
    assert_equal 'FOO', map.name
  end

  test 'should show destinations of the map' do
    destinations = Map.first.cities.all_destinations
    assert destinations.present?
  end
end