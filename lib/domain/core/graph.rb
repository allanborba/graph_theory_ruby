require_relative "vertex"
require_relative "../core/adjacency_matrix"

class Graph
  attr_reader :vertices, :index_by_label

  def initialize(max_vertices_allowed = 10)
    raise ArgumentError, "Max vertices must be a number" unless max_vertices_allowed.instance_of?(Integer)
    raise ArgumentError, "Max vertices must be equal or greater than one" if max_vertices_allowed < 1

    @max_vertices_allowed = max_vertices_allowed
    @vertices = []
    @vertex_index = 0
    @index_by_label = {} # allow to get index of a vertex in O(1) time
  end

  def add_vertex(label)
    raise ArgumentError, "Max allowed vertices has been exceeded" if vertices.size == @max_vertices_allowed

    index_by_label[label] = @vertex_index
    vertices << Vertex.new(label)
    @vertex_index += 1
  end

  def connect_vertex_by_label(initial, final, weight = 1)
    validate_label_existence([initial, final])

    initial_vertex_index = index_by_label[initial]
    final_vertex_index = index_by_label[final]
    adjacency_matrix.add_edge(initial_vertex_index, final_vertex_index, weight)
  end

  def get_adjacencies(label)
    validate_label_existence([label])

    adjacency_matrix.get_adjacencies(index_by_label[label])
  end

  def get_weight(initial_label, final_label)
    initial_index = index_by_label[initial_label]
    final_index = index_by_label[final_label]

    adjacency_matrix.matrix[initial_index][final_index]
  end

  def spanning_tree_by_depth
    tree = Graph.new(@max_vertices_allowed)
    stack = []
    visited_vertices = {}

    vertices.each { |v| tree.add_vertex(v.label) }

    visited_vertices[0] = vertices[0].label
    stack << vertices[0]

    while stack.any?
      vertex = stack.last
      next_vertex = get_next_vertex(vertex, visited_vertices)

      if next_vertex.nil?
        stack.pop
      else
        index = index_by_label[next_vertex.label]
        visited_vertices[index] = next_vertex.label
        stack << next_vertex
        tree.connect_vertex_by_label(vertex.label, next_vertex.label)
      end
    end

    tree
  end

  protected

  def adjacency_matrix
    @adjacency_matrix ||= AdjacencyMatrix.new(vertices)
  end

  def validate_label_existence(labels)
    raise ArgumentError, "Label must be a String" if labels.any? { |l| !l.instance_of?(String) }
    raise ArgumentError, "Label must exist" if labels.any? { |l| index_by_label[l].nil? }
  end

  def get_next_vertex(vertex, vertices_hash)
    adjacencies = get_adjacencies(vertex.label)
    adjacencies.each do |adjacency|
      index = index_by_label[adjacency.label]

      return adjacency if vertices_hash[index].nil?
    end

    nil
  end
end
