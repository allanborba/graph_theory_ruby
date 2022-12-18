class AdjacencyMatrix
  attr_reader :vertices, :matrix

  def initialize(vertices)
    raise ArgumentError, "Argument must be a list of vertices" if vertices.any?{|v| !v.instance_of?(Vertex)}

    @vertices = vertices
    initialize_matrix
  end

  def add_edge(initial_vertex_index, final_vertex_index)
    raise ArgumentError, "index must be a number" unless initial_vertex_index.instance_of?(Integer) && final_vertex_index.instance_of?(Integer)
    raise ArgumentError, "index must be inside matrix size" if initial_vertex_index > vertices.size || final_vertex_index > vertices.size

    matrix[initial_vertex_index][final_vertex_index] = 1
    vertices[initial_vertex_index].add_degree

    return if initial_vertex_index == final_vertex_index

    matrix[final_vertex_index][initial_vertex_index] = 1
    vertices[final_vertex_index].add_degree
  end

  def get_adjacencies(vertex_index)
    adjacencies = []

    vertices.size.times do |i|
      adjacencies << vertices[i] if matrix[vertex_index][i] == 1
    end

    adjacencies
  end

  private

  def initialize_matrix
    @matrix = Array.new(vertices.size)

    vertices.size.times {|i| matrix[i]= Array.new(vertices.size, 0)}
  end
end
