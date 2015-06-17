require 'test_helper'

class GraphTest < ActiveSupport::TestCase
  def setup
    @graph = Graph.new(City.destinations)
    @shortest_paths = @graph.shortest_path('A', 'C')
  end

  test 'should be kind of Graph' do
    assert_kind_of Graph, @graph
  end

  test 'should be kind of Array on shortest_paths' do
    assert_equal 2, @shortest_paths.count
    assert_kind_of Array, @shortest_paths
  end

  test 'should be kind of Array the first element on shortest_paths' do
    assert_kind_of Array, @shortest_paths.first
  end

  test 'should be kind of Fixnum the last element on shortest_paths' do
    assert_kind_of Fixnum, @shortest_paths.last
  end
end