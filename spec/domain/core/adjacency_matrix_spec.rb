require "domain/core/adjacency_matrix"

describe AdjacencyMatrix do
  let(:vertex_A) { Vertex.new("A") }
  let(:vertex_B) { Vertex.new("B") }
  let(:vertex_C) { Vertex.new("C") }
  let(:vertex_D) { Vertex.new("D") }
  let(:vertices) { [vertex_A, vertex_B, vertex_C, vertex_D] }

  describe "#initialize" do
    context "when the argument is not a list of vectices" do
      let(:wrong_args) { ["A", "B", "C", "D"] }

      it do
        expect { described_class.new(wrong_args) }.to raise_error(ArgumentError, "Argument must be a list of vertices")
      end
    end

    context "when the argument is valid" do
      let(:adjacency_matrix) { described_class.new(vertices) }
      let(:result_matrix) { [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]] }

      it("initialize the matrix") { expect(adjacency_matrix.matrix).to eq(result_matrix) }
    end
  end

  describe "#add_edge" do
    let(:adjacency_matrix) { described_class.new(vertices) }

    context "when the vertices are not a number" do
      it { expect { adjacency_matrix.add_edge("1", 3) }.to raise_error(ArgumentError, "index must be a number") }
    end

    context "when the index not present in vertices" do
      it { expect { adjacency_matrix.add_edge(1, 5) }.to raise_error(ArgumentError, "index must be inside matrix size") }
    end

    context "when the weight is not a number" do
      it { expect { adjacency_matrix.add_edge(1, 3, "1") }.to raise_error(ArgumentError, "weight must be a number") }
    end

    context "when add edge with no weight" do
      let(:result_matrix) { [[0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0], [0, 1, 0, 0]] }

      before { adjacency_matrix.add_edge(1, 3) }

      it("change the value of matrix") { expect(adjacency_matrix.matrix).to eq(result_matrix) }
      it("change the degree of each vertex") { expect(vertices.map(&:degree)).to eq([0, 1, 0, 1]) }
    end

    context "when add edge with weight" do
      let(:result_matrix) { [[0, 0, 0, 0], [0, 0, 0, 5], [0, 0, 0, 0], [0, 5, 0, 0]] }

      before { adjacency_matrix.add_edge(1, 3, 5) }

      it("change the value of matrix") { expect(adjacency_matrix.matrix).to eq(result_matrix) }
      it("change the degree of each vertex") { expect(vertices.map(&:degree)).to eq([0, 1, 0, 1]) }
    end
  end

  describe "#add_directed_edge" do
    let(:adjacency_matrix) { described_class.new(vertices) }
    let(:result_matrix) { [[0, 0, 0, 0], [0, 0, 0, 5], [0, 0, 0, 0], [0, 0, 0, 0]] }

    before { adjacency_matrix.add_directed_edge(1, 3, 5) }

    context "when add edge" do
      it("change the value of matrix") { expect(adjacency_matrix.matrix).to eq(result_matrix) }
      it("change the degree of each vertex") { expect(vertices.map(&:degree)).to eq([0, 0, 0, 1]) }
    end
  end

  describe "#copy_matrix_values" do
    let(:adjacency_matrix) { described_class.new(vertices) }

    context "when the argument isnt a matrix" do
      it do
        expect { adjacency_matrix.copy_matrix_values("matrix") }
          .to raise_error(ArgumentError, "Argument must be a Matrix")
      end
    end

    context "when the matrix has diff sizes" do
      let(:new_matrix) { described_class.new([vertex_A, vertex_B]) }

      it do
        expect { adjacency_matrix.copy_matrix_values(new_matrix) }
          .to raise_error(ArgumentError, "Matrix must have same size")
      end
    end

    context "when receive valid matrix as argument" do
      let(:new_matrix) { described_class.new(vertices) }
      let(:result_matrix) { [[0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 0], [0, 1, 0, 0]] }

      before do
        adjacency_matrix.add_edge(1, 3)
        adjacency_matrix.copy_matrix_values(new_matrix)
      end

      it("to copy the values") { expect(new_matrix.matrix).to eq(result_matrix) }
    end
  end

  describe "#get_adjacencies" do
    let(:adjacency_matrix) { described_class.new(vertices) }

    before { adjacency_matrix.add_edge(1, 3) }

    it("returns the adjacencies") { expect(adjacency_matrix.get_adjacencies(1)).to eq([vertex_D]) }
  end
end
