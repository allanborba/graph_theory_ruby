require "singleton"
require_relative "path"

class DepthFristSearch
  include Singleton

  def search(graph, beginning, destination)
    raise ArgumentError, "graph must be a Graph type" unless graph.is_a?(Graph)

    graph.validate_label_existence(beginning, destination)

    stack = []
    visited_vertices = []
    path = Path.new

    stack << beginning

    while stack.any?
      vertex = stack.pop
      break if vertex == destination

      graph.get_adjacencies(vertex).each do |adjacent_vertex|
        label = adjacent_vertex.label

        next if visited_vertices.include?(label)

        visited_vertices << label
        path.connect(label, vertex)
        stack << label
      end
    end

    path.generate(beginning, destination)
  end
end
