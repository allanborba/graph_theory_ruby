require "domain/core/graph"

def generate_graph
  graph = Graph.new

  graph.add_vertex("A");
  graph.add_vertex("B");
  graph.add_vertex("C");
  graph.add_vertex("D");
  graph.add_vertex("E");
  graph.add_vertex("F");
  graph.add_vertex("G");
  graph.add_vertex("H");
  graph.add_vertex("I");

  graph.connect_vertex_by_label("A", "B");
  graph.connect_vertex_by_label("A", "C");
  graph.connect_vertex_by_label("A", "D");
  graph.connect_vertex_by_label("A", "D");
  graph.connect_vertex_by_label("B", "F");
  graph.connect_vertex_by_label("B", "I");
  graph.connect_vertex_by_label("D", "E");
  graph.connect_vertex_by_label("D", "I");
  graph.connect_vertex_by_label("D", "G");
  graph.connect_vertex_by_label("I", "A");
  graph.connect_vertex_by_label("I", "D");
  graph.connect_vertex_by_label("I", "C");
  graph.connect_vertex_by_label("I", "H");
  graph.connect_vertex_by_label("E", "A");

  graph
end
