class Graph
  Vertex = Struct.new(:name, :neighbours, :distance, :previous)

  def initialize(graph)
    @vertices = Hash.new do |key, value|
      key[value] = Vertex.new(value, [], Float::INFINITY)
    end

    @edges = {}

    graph.each do |(vertice_one, vertice_two, distance)|
      @vertices[vertice_one].neighbours << vertice_two
      @vertices[vertice_two].neighbours << vertice_one
      @edges[[vertice_one, vertice_two]] = @edges[[vertice_two, vertice_one]] = distance
    end

    @dijkstra_source = nil
  end

  def dijkstra(source)
    return if @dijkstra_source == source

    queue = @vertices.values
    queue.each do |vertice|
      vertice.distance = Float::INFINITY
      vertice.previous = nil
    end

    @vertices[source].distance = 0

    until queue.empty?
      route = queue.min_by {|vertex| vertex.distance}
      break if route.distance == Float::INFINITY

      queue.delete(route)
      route.neighbours.each do |v|
        vertice = @vertices[v]
        if queue.include?(vertice)
          alt = route.distance + @edges[[route.name, v]]
          if alt < vertice.distance
            vertice.distance = alt
            vertice.previous = route.name
          end
        end
      end
    end

    @dijkstra_source = source
  end

  def shortest_path(source, target)
    dijkstra(source)
    path = []
    u = target

    while u
      path.unshift(u)
      u = @vertices[u].previous
    end

    return path, @vertices[target].distance
  end
end