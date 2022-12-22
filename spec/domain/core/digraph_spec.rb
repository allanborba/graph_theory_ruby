require "domain/core/digraph"

describe Digraph do
  describe "#connect_vertex_by_label" do
    let(:adjacency_matrix_mock) { instance_double(AdjacencyMatrix) }
    let(:digraph) { described_class.new }
    let(:index_of_vertex_a) { 0 }
    let(:index_of_vertex_b) { 1 }
    let(:weight) { 5 }
    let(:arguments) { [index_of_vertex_a, index_of_vertex_b, weight] }

    before do
      allow(AdjacencyMatrix).to receive(:new).and_return(adjacency_matrix_mock)
      allow(adjacency_matrix_mock).to receive(:add_directed_edge)
      digraph.add_vertex("A")
      digraph.add_vertex("B")
    end

    context "when the label is valid" do
      before { digraph.connect_vertex_by_label("A", "B", weight) }

      it "call matrix add_adge method" do
        expect(adjacency_matrix_mock).to have_received(:add_directed_edge).with(*arguments)
      end
    end

    context "when the label is invalid" do
      it { expect { digraph.connect_vertex_by_label("A", "C") }.to raise_error(ArgumentError, "Label must exist") }
    end
  end

  describe "#spanning_tree_by_depth" do
    let(:digraph) { described_class.new }

    before do
      digraph.add_vertex("A")
      digraph.add_vertex("B")
      digraph.add_vertex("C")
      digraph.add_vertex("D")

      digraph.connect_vertex_by_label("A", "B")
      digraph.connect_vertex_by_label("B", "C")
      digraph.connect_vertex_by_label("A", "C")
      digraph.connect_vertex_by_label("A", "D")
    end

    context "when receive a root" do
      let(:tree) { digraph.spanning_tree_by_depth("C") }

      it { expect(tree.get_adjacencies("A").map(&:label)).to eq(["B", "D"]) }
      it { expect(tree.get_adjacencies("B").map(&:label)).to eq(["C"]) }
      it { expect(tree.get_adjacencies("C")).to eq([]) }
      it { expect(tree.get_adjacencies("D")).to eq([]) }
    end

    context "when not receive a root" do
      let(:tree) { digraph.spanning_tree_by_depth() }

      it { expect(tree.get_adjacencies("A").map(&:label)).to eq(["B", "D"]) }
      it { expect(tree.get_adjacencies("B").map(&:label)).to eq(["C"]) }
      it { expect(tree.get_adjacencies("C")).to eq([]) }
      it { expect(tree.get_adjacencies("D")).to eq([]) }
    end
  end
end
