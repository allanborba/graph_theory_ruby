class Graph
  attr_reader :vertices, :indexed_label

  def initialize(max_vertices_allowed = 10)
    raise ArgumentError.new('Max vertices must be a number') unless max_vertices_allowed.class == Integer
    raise ArgumentError.new('Max vertices must be equal or greater than one') if max_vertices_allowed < 1

    @max_vertices_allowed = max_vertices_allowed
    @vertices = []
    @vertex_index = 0
    @indexed_label = Hash.new { |h, k| h[k] = @vertex_index } # allow to get index of a vertice in O(1) time
  end

  def add_vertex(label)
    raise ArgumentError.new('Max allowed vertices has been exceeded') if vertices.size == @max_vertices_allowed

    indexed_label[label]
    vertices << Vertex.new(label)
    @vertex_index += 1
  end
end
