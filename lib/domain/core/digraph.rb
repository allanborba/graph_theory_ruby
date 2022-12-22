require_relative "graph"

class Digraph < Graph

  def connect_vertex_by_label(initial, final, weight = 1)
    validate_label_existence([initial, final])

    initial_vertex_index = index_by_label[initial]
    final_vertex_index = index_by_label[final]
    adjacency_matrix.add_directed_edge(initial_vertex_index, final_vertex_index, weight)
  end

  def spanning_tree_by_depth(root = nil)
    validate_label_existence([root]) if root

    root ||= vertices[0].label
    root_index = index_by_label[root]
    to_visit = index_by_label.dup.except(root)

    tree = Digraph.new(@max_vertices_allowed)
    vertices.each { |v| tree.add_vertex(v.label) }
    look_into(root, to_visit, tree)

    while to_visit.any?
      break if adjacency_matrix.ancestors[root_index].empty?

      ancestral = nil
      adjacency_matrix.ancestors[root_index].each do |v|
        if to_visit[v.label]
          ancestral = v.label
          break
        end
      end

      raise "unconnected digraph" if ancestral.nil?

      to_visit.delete(ancestral)
      tree.connect_vertex_by_label(ancestral, root)
      root = ancestral
      root_index = index_by_label[root]
      look_into(root, to_visit, tree)
    end

    tree
  end

  private

  def look_into(root, to_visit, tree)
    get_adjacencies(root).each do |next_door|
      next if to_visit[next_door.label].nil?

      tree.connect_vertex_by_label(root, next_door.label)
      to_visit.delete(next_door.label)
      look_into(next_door.label, to_visit, tree)
    end
  end
end
