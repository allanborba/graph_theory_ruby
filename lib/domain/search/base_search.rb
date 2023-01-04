require_relative "path"
require "singleton"

class BaseSearch
  include Singleton

  def search(graph, beginning, destination, base_structure)
    raise ArgumentError, "graph must be a Graph type" unless graph.is_a?(Graph)

    base_structure.add beginning

    while base_structure.any?
      vertex = base_structure.remove
      break if vertex == destination

      connect_path(base_structure, graph, vertex)
    end

    path.generate(beginning, destination)
  end

  private

  def visited_vertices
    @visited_vertices ||= {}
  end

  def path
    @path ||= Path.new
  end

  def connect_path(base_structure, graph, vertex)
    graph.get_adjacencies(vertex).each do |adjacent_vertex|
      label = adjacent_vertex.label
      index = graph.index_by_label[label]

      next unless visited_vertices[index].nil?

      visited_vertices[index] = label
      path.connect(label, vertex)
      base_structure.add label
    end
  end
end
