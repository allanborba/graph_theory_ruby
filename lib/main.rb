require_relative 'graph/core/graph'
require_relative 'graph/core/vertex'

graph = Graph.new

graph.add_vertex("RJ")
graph.add_vertex("SP")
graph.add_vertex("BH")
graph.add_vertex("PT")

graph.vertices.each { |v| p v.label }
p graph.indexed_label["SP"]