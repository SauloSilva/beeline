require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  test 'should not save Route when invalid' do
    route = Route.new
    assert_not route.save
  end

  test 'should not save Route without from_id' do
    route = Route.new(to_id: 1, distance: 1)
    assert_not route.save
  end

  test 'should not save Route without to_id' do
    route = Route.new(from_id: 1, distance: 1)
    assert_not route.save
  end

  test 'should not save Route without distance' do
    route = Route.new(from_id: 1, to_id: 2)
    assert_not route.save
  end

  test 'should be kind of City object through relationship belongs_to :from' do
    from = Route.first.from
    assert_kind_of City, from
  end

  test 'should be kind of City object through relationship belongs_to :to' do
    to = Route.first.to
    assert_kind_of City, to
  end

  test 'should return Hash on shortest_path method' do
    shortest_path = Route.shortest_path('A', 'C', 1, 1)
    assert_kind_of Hash, shortest_path
    assert_kind_of Array, shortest_path[:nodes]
    assert_kind_of Fixnum, shortest_path[:distance]
    assert_kind_of Float, shortest_path[:price]
  end

  test 'should not save Route with from_id and to_id already existing' do
    route = Route.new Route.first.attributes
    assert_not route.save
  end

  test 'should create City and save Route when name city to inserted in to' do
    Route.create(from_id: 1, to: 'bar', distance: 1)
    assert City.where(name: 'Bar').exists?
  end
end