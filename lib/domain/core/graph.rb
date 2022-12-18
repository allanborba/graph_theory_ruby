require_relative 'vertex'
require_relative '../core/adjacency_matrix'

class Graph
  attr_reader :vertices, :index_by_label

  def initialize(max_vertices_allowed = 10)
    raise ArgumentError.new('Max vertices must be a number') unless max_vertices_allowed.instance_of?(Integer)
    raise ArgumentError.new('Max vertices must be equal or greater than one') if max_vertices_allowed < 1

    @max_vertices_allowed = max_vertices_allowed
    @vertices = []
    @vertex_index = 0
    @index_by_label = {} # allow to get index of a vertex in O(1) time
  end

  def add_vertex(label)
    raise ArgumentError.new('Max allowed vertices has been exceeded') if vertices.size == @max_vertices_allowed

    index_by_label[label] = @vertex_index
    vertices << Vertex.new(label)
    @vertex_index += 1
  end

  def connect_vertex_by_label(initial, final)
    raise ArgumentError.new('Label must be a String') unless initial.instance_of?(String) && final.instance_of?(String)

    validate_label_existence(initial, final)

    initial_vertex_index = index_by_label[initial]
    final_vertex_index = index_by_label[final]
    adjacency_matrix.add_edge(initial_vertex_index, final_vertex_index)
  end

  def get_adjacencies(label)
    raise ArgumentError.new('Label must exist') if index_by_label[label].nil?

    adjacency_matrix.get_adjacencies(index_by_label[label])
  end

  def get_vertex(label)
    vertices[index_by_label[label]]
  end

  def validate_label_existence(initial, final)
    raise ArgumentError.new('Label must exist') if index_by_label[initial].nil? || index_by_label[final].nil?
  end

  private

  def adjacency_matrix
    @adjacency_matrix ||= AdjacencyMatrix.new(vertices)
  end
end
