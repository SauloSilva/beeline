class Route < ActiveRecord::Base
  validates :from_id, :to_id, :distance, presence: true
  validates :to_id, uniqueness: { scope: :from_id }
  validates :from_id, uniqueness: { scope: :to_id }
  validate :distinct_nodes

  belongs_to :from, foreign_key: :from_id, class_name: :City
  belongs_to :to, foreign_key: :to_id, class_name: :City

  def to=(to)
    self.to_id = City.where(name: to).first_or_create.id
  end

  def self.shortest_path(from, to, autonomy, fuel_price)
    graph = Graph.new(City.all_destinations)
    nodes, distance = graph.shortest_path(from.capitalize, to.capitalize)

    fuel_price = if fuel_price.is_a? String
      fuel_price.gsub(',', '.').to_f
    else
      fuel_price
    end

    price = (distance.to_f / autonomy.to_f) * fuel_price

    {
      nodes: nodes,
      distance: distance,
      price: price.round(2)
    }
  end

  private
  def distinct_nodes
    if to_id == from_id
      errors.add(:model_years, 'The nodes are not distinct')
    end
  end
end