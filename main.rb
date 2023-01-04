require_relative "lib/domain/core/graph"
require_relative "lib/domain/core/digraph"
require_relative "lib/domain/search/breadth_first_search"
require_relative "lib/domain/search/depth_first_search"

# ----
# graph = Graph.new

# graph.add_vertex("RJ")
# graph.add_vertex("SP")
# graph.add_vertex("BH")
# graph.add_vertex("PT")

# graph.vertices.each { |v| p v.label }
# p graph.index_by_label["SP"]

# ----
# graph = Graph.new

# graph.add_vertex("A")
# graph.add_vertex("B")
# graph.add_vertex("C")
# graph.add_vertex("D")

# graph.connect_vertex_by_label("A", "B")
# graph.connect_vertex_by_label("A", "C")
# graph.connect_vertex_by_label("A", "D")

# puts "Degree of A vertex: #{graph.get_vertex('A').degree}"
# puts "Degree of A vertex: #{graph.get_vertex('C').degree}"
# puts "Degree of A vertex: #{graph.get_vertex('D').degree}"

# puts "Vertex A adjacencies: "
# graph.get_adjacencies("A").each { |v| print "#{v.label} " }
# puts

# puts "Vertex B adjacencies: "
# graph.get_adjacencies("B").each { |v| print "#{v.label} " }
# puts

# ----
# graph = Graph.new

# graph.add_vertex("A")
# graph.add_vertex("B")
# graph.add_vertex("C")
# graph.add_vertex("D")
# graph.add_vertex("E")
# graph.add_vertex("F")
# graph.add_vertex("G")
# graph.add_vertex("H")
# graph.add_vertex("I")

# graph.connect_vertex_by_label("A", "B")
# graph.connect_vertex_by_label("A", "C")
# graph.connect_vertex_by_label("A", "D")
# graph.connect_vertex_by_label("A", "D")
# graph.connect_vertex_by_label("B", "F")
# graph.connect_vertex_by_label("B", "I")
# graph.connect_vertex_by_label("D", "E")
# graph.connect_vertex_by_label("D", "I")
# graph.connect_vertex_by_label("D", "G")
# graph.connect_vertex_by_label("I", "A")
# graph.connect_vertex_by_label("I", "D")
# graph.connect_vertex_by_label("I", "C")
# graph.connect_vertex_by_label("I", "H")
# graph.connect_vertex_by_label("E", "A")

# path = DepthFirstSearch.instance.search(graph, "D", "H")
# puts "Depth First Sarch: "
# path.each { |v| print "#{v} "}
# puts

# path = BreadthFristSearch.instance.search(graph, "D", "H")
# puts "Breadth First Sarch: "
# path.each { |v| print "#{v} "}
# puts

# tree = graph.spanning_tree_by_depth
# puts "--- Spanning tree ---"
# puts "Vertices"
# tree.vertices.each { |v| print "\t #{v.label}"}
# puts

# puts "Edges"
# tree.vertices.each do |v|
#   tree.get_adjacencies(v.label).each { |adj| print "\t #{v.label} #{adj.label}"}
# end
# puts

#---
digraph = Digraph.new

digraph.add_vertex("RJ")
digraph.add_vertex("SP")
digraph.add_vertex("BH")
digraph.add_vertex("PT")
digraph.add_vertex("OS")
digraph.add_vertex("SV")
digraph.add_vertex("CR")
digraph.add_vertex("PA")

digraph.connect_vertex_by_label("RJ", "SP")
digraph.connect_vertex_by_label("RJ", "BH")
digraph.connect_vertex_by_label("RJ", "PT")
digraph.connect_vertex_by_label("RJ", "PA")
digraph.connect_vertex_by_label("SP", "BH")
digraph.connect_vertex_by_label("SP", "OS")
digraph.connect_vertex_by_label("SP", "SV")
digraph.connect_vertex_by_label("SP", "CR")
digraph.connect_vertex_by_label("SP", "PA")
digraph.connect_vertex_by_label("SV", "PA")
digraph.connect_vertex_by_label("CR", "PA")

tree = digraph.spanning_tree_by_depth("PT")
puts "--- Tree on digraph using root ---"
tree.vertices.each do |v|
  print "Vertex #{v.label} conected to "
  adjacencies = tree.get_adjacencies(v.label)
  print " - " if adjacencies.empty?

  adjacencies.each { |adj| print "#{adj.label} "}
  puts
end
puts "---  ---"

weighted_graph = Graph.new
weighted_graph.add_vertex("A")
weighted_graph.add_vertex("B")
weighted_graph.add_vertex("C")
weighted_graph.add_vertex("D")
weighted_graph.add_vertex("E")

weighted_graph.connect_vertex_by_label("A", "B", 12)
weighted_graph.connect_vertex_by_label("C", "E", 10)
weighted_graph.connect_vertex_by_label("B", "D", 5)
weighted_graph.connect_vertex_by_label("D", "A", 2)
weighted_graph.connect_vertex_by_label("B", "E", 1)
weighted_graph.connect_vertex_by_label("A", "C", 7)

puts "Weighted graph"
weight = weighted_graph.get_weight("A", "B")
puts "Weight of edge AB: #{weight}"
weight = weighted_graph.get_weight("B", "E")
puts "Weight of edge BE: #{weight}"

weighted_digraph = Digraph.new

weighted_digraph.add_vertex("X")
weighted_digraph.add_vertex("Y")
weighted_digraph.add_vertex("Z")
weighted_digraph.add_vertex("W")
weighted_digraph.add_vertex("V")

weighted_digraph.connect_vertex_by_label("X", "V", 44)
weighted_digraph.connect_vertex_by_label("Y", "W", 37)
weighted_digraph.connect_vertex_by_label("W", "Z", 38)
weighted_digraph.connect_vertex_by_label("X", "V", 16)
weighted_digraph.connect_vertex_by_label("V", "X", 22)
weighted_digraph.connect_vertex_by_label("V", "Y", 57)

puts "--- Weighted digraph ---"
print "Vertex"
weighted_digraph.vertices.each { |v| print "\t #{v.label}" }
puts
puts "Edges"
weighted_digraph.vertices.each do |v|
  weighted_digraph.get_adjacencies(v.label).each do |adj|
    puts "\t #{v.label+adj.label} : #{weighted_digraph.get_weight(v.label, adj.label)}"
  end
end
