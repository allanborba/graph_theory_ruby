require "domain/search/breadth_first_search"
require_relative "../../graph_helper"

describe BreadthFristSearch do
  describe "#search" do
    let(:graph) { generate_graph }
    let(:path_result) { ["A", "D", "G"] }

    context "when graph its not a Graph instance" do
      it do
        expect { described_class.instance.search("graph", "A", "G") }
          .to raise_error(ArgumentError, "graph must be a Graph type")
      end
    end

    context "when vertices dont belong to graph" do
      it do
        debugger
        expect { described_class.instance.search(graph, "X", "Z") }.to raise_error(ArgumentError, "Label must exist")
      end
    end

    context "when vertices belong to graph" do
      it("returns the vertices path") { expect(described_class.instance.search(graph, "A", "G")).to eq(path_result) }
    end
  end
end
