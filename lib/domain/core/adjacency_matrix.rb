class AdjacencyMatrix
  attr_reader :vertices, :ancestors, :matrix_size, :matrix

  def initialize(vertices)
    raise ArgumentError, "Argument must be a list of vertices" if vertices.any? { |v| !v.instance_of?(Vertex) }

    @vertices = vertices
    @ancestors = Hash.new {|hash, k| hash[k] = []}
    @matrix_size = vertices.size
    initialize_matrix
  end

  def add_edge(initial_vertex_index, final_vertex_index, weight = 1)
    validate_vertices_index([initial_vertex_index, final_vertex_index])
    validate_weight(weight)

    write_in_matrix(initial_vertex_index, final_vertex_index, weight)
    vertices[initial_vertex_index].add_degree

    return if initial_vertex_index == final_vertex_index

    write_in_matrix(final_vertex_index, initial_vertex_index, weight)
    vertices[final_vertex_index].add_degree
  end

  def add_directed_edge(initial_vertex_index, final_vertex_index, weight = 1)
    validate_vertices_index([initial_vertex_index, final_vertex_index])
    validate_weight(weight)

    write_in_matrix(initial_vertex_index, final_vertex_index, weight)
    vertices[final_vertex_index].add_degree

    ancestors[final_vertex_index] << vertices[initial_vertex_index]
  end

  def get_adjacencies(vertex_index)
    validate_vertices_index([vertex_index])

    adjacencies = []
    matrix_size.times do |i|
      adjacencies << vertices[i] if matrix[vertex_index][i] != 0
    end

    adjacencies
  end

  def copy_matrix_values(destination_matrix)
    validate_matrix(destination_matrix)

    matrix_size.times do |i|
      matrix_size.times { |j| destination_matrix.write_in_matrix(i, j, matrix[i][j]) }
    end
  end

  private

  def initialize_matrix
    @matrix = Array.new(matrix_size)

    matrix_size.times { |i| matrix[i]= Array.new(vertices.size, 0) }
  end

  def validate_vertices_index(list_of_index)
    raise ArgumentError, "index must be a number" if list_of_index.any? { |i| !i.instance_of?(Integer) }
    raise ArgumentError, "index must be inside matrix size" if list_of_index.any? { |i| i > vertices.size }
  end

  def validate_weight(weight)
    raise ArgumentError, "weight must be a number" unless weight.instance_of?(Integer)
  end

  def validate_matrix(matrix)
    raise ArgumentError, "Argument must be a Matrix" unless matrix.is_a?(AdjacencyMatrix)
    raise ArgumentError, "Matrix must have same size" unless matrix.matrix_size == matrix_size
  end

  protected

  def write_in_matrix(line, column, weight)
    matrix[line][column] = weight
  end
end
