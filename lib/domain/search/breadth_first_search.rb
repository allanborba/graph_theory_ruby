require "singleton"
require_relative "path"

class BreadthFristSearch
  include Singleton

  def search(graph, beginning, destination)
    raise ArgumentError, "graph must be a Graph type" unless graph.is_a?(Graph)

    fifo = []
    visited_vertices = []
    path = Path.new

    fifo << beginning

    while fifo.any?
      vertex = fifo.shift
      break if vertex == destination

      graph.get_adjacencies(vertex).each do |adjacent_vertex|
        label = adjacent_vertex.label

        next if visited_vertices.include?(label)

        visited_vertices << label
        path.connect(label, vertex)
        fifo << label
      end
    end

    path.generate(beginning, destination)
  end
end
