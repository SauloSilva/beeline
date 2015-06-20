require 'test_helper'

class CityTest < ActiveSupport::TestCase
  def setup
    @destinations = City.first.destinations.to_format!
    @all_destinations = City.all_destinations
  end

  test 'should not save city without name' do
    city = City.new
    assert_not city.save
  end

  test 'should not save city with same name' do
    city = City.new(name: 'A')
    assert_not city.save
  end

  test 'should format destination of the first city' do
    assert_equal 1, @destinations.count
  end

  test 'should be String the first attributes of the formatted Object' do
    assert_kind_of String, @destinations.flatten.first
  end

  test 'should be String the second attributes of the formatted Object' do
    assert_kind_of String, @destinations.flatten[1]
  end

  test 'should be Fixnum the last attributes of the formatted Object' do
    assert_kind_of Fixnum, @destinations.flatten.last
  end

  test 'should return all destinations' do
    assert_equal 3, @all_destinations.count
  end

  test 'should delete all routes dependent' do
    count = Route.count
    City.first.destroy

    assert_not_equal count, Route.count
  end

  test 'should create map when have map_name' do
    city = City.new(name: 'foo', map_name: 'bar')
    assert_equal 'BAR', city.map.name
  end

  test 'should create routes when there is an Array of object into routes attribute' do
    city = City.new(name: 'foo', routes: [
      { to: 'bar', distance: 1 },
      { to: 'baz', distance: 2 }
    ])

    city.save

    assert_equal 2, city.destinations.count
  end

  test 'should update routes when there is an Array of object into routes attribute' do
    city = City.find(1)
    city.update_attributes({routes: [
      { to: 'bar', distance: 99 },
    ]})

    assert_equal 'Bar', city.destinations.first.to.name
    assert_equal 99, city.destinations.first.distance
  end

  test 'should capitalize name' do
    city = City.create(name: 'foo')
    assert_equal 'Foo', city.name
  end
end