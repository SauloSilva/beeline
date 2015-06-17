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
end