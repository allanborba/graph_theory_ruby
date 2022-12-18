require "domain/core/graph"
require "domain/core/vertex"

describe Graph do
  describe "#initialize" do
    context "when the argument is not a number" do
      it {expect{described_class.new("A")}.to raise_error(ArgumentError, "Max vertices must be a number")}
    end

    context "when the argument number less then 1" do
      it {expect{described_class.new(0)}.to raise_error(ArgumentError, "Max vertices must be equal or greater than one")}
    end
  end

  describe "#add_vertex" do
    context "when the number of vertices exceed the max allowed" do
    let(:graph) {described_class.new(1)}

    before {graph.add_vertex("A")}

      it {expect{graph.add_vertex("B")}.to raise_error(ArgumentError, "Max allowed vertices has been exceeded")}
    end

    context "when the number of vertices is valid" do
      let(:graph) {described_class.new(2)}

      before {graph.add_vertex("A")}

      it("get the index by label") {expect(graph.index_by_label["A"]).to eq(0)}
      it("incress the vertices size") {expect{graph.add_vertex("B")}.to change(graph.vertices, :count).by(1)}
    end
  end

  describe "#connect_vertex_by_label" do
    let(:adjacency_matrix_mock) {instance_double(AdjacencyMatrix)}
    let(:graph) {described_class.new}
    let(:index_of_vertex_a) {0}
    let(:index_of_vertex_b) {1}

    before do
      allow(AdjacencyMatrix).to receive(:new).and_return(adjacency_matrix_mock)
      allow(adjacency_matrix_mock).to receive(:add_edge)
      graph.add_vertex("A")
      graph.add_vertex("B")
    end

    context "when the label is valid" do
      before {graph.connect_vertex_by_label("A", "B")}

      it "call matrix add_adge method" do
        expect(adjacency_matrix_mock).to have_received(:add_edge).with(index_of_vertex_a, index_of_vertex_b)
      end
    end

    context "when the label is invalid" do
      it {expect {graph.connect_vertex_by_label("A", "C")}.to raise_error(ArgumentError, "Label must exist")}
    end
  end

  describe "#get_adjcencies" do
    let(:adjacency_matrix_mock) {instance_double(AdjacencyMatrix)}
    let(:graph) {described_class.new}
    let(:index_of_vertex) {0}

    before do
      allow(AdjacencyMatrix).to receive(:new).and_return(adjacency_matrix_mock)
      allow(adjacency_matrix_mock).to receive(:get_adjacencies)
      graph.add_vertex("A")
    end

    context "when the label is" do
      before {graph.get_adjacencies("A")}

      it "call adjacency matrix get_adjacencies method" do
        expect(adjacency_matrix_mock).to have_received(:get_adjacencies).with(index_of_vertex)
      end
    end

    context "when the label is invalid" do
      it {expect {graph.get_adjacencies("C")}.to raise_error(ArgumentError, "Label must exist")}
    end
  end
end
