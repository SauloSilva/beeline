class Route < ActiveRecord::Base
  validates :from_id, :to_id, :distance, presence: true

  belongs_to :from, foreign_key: :from_id, class_name: :City
  belongs_to :to, foreign_key: :to_id, class_name: :City

  def self.shortest_path(from, to)
    graph = Graph.new(City.destinations)
    nodes, dist = graph.shortest_path(from, to)

    {
      nodes: nodes,
      distance: dist
    }
  end
end