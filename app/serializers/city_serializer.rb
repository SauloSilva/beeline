class CitySerializer < ActiveModel::Serializer
  attributes :name, :routes, :map_name

  def map_name
    object.map.name
  end

  def routes
    object.destinations.map do |route|
      {
        to: route.to.name,
        distance: route.distance
      }
    end
  end
end