require "singleton"
require_relative "path"

class DepthFirstSearch
  include Singleton

  def search(graph, beginning, destination)
    raise ArgumentError, "graph must be a Graph type" unless graph.is_a?(Graph)

    stack = []
    visited_vertices = {}
    path = Path.new

    stack << beginning

    while stack.any?
      vertex = stack.pop
      break if vertex == destination

      graph.get_adjacencies(vertex).each do |adjacent_vertex|
        label = adjacent_vertex.label
        index = graph.index_by_label[label]

        next unless visited_vertices[index].nil?

        visited_vertices[index] = label
        path.connect(label, vertex)
        stack << label
      end
    end

    path.generate(beginning, destination)
  end
end
