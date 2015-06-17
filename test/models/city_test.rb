require 'test_helper'

class CityTest < ActiveSupport::TestCase
  def setup
    @destinations = City.first.destinations.to_format!
    @all_destinations = City.destinations
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
end