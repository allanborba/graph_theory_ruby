require 'graph/core/adjacency_matrix'

describe AdjacencyMatrix do
  let(:vertex_A) {Vertex.new('A')}
  let(:vertex_B) {Vertex.new('B')}
  let(:vertex_C) {Vertex.new('C')}
  let(:vertex_D) {Vertex.new('D')}
  let(:vertices) {[vertex_A, vertex_B, vertex_C, vertex_D]}

  describe '#initialize' do
    context 'when the argument is not a list of vectices' do
      let(:wrong_args) {['A', 'B', 'C', 'D']}

      it {expect{described_class.new(wrong_args)}.to raise_error(ArgumentError, 'Argument must be a list of vertices')}
    end

    context 'when the argument is valid' do
      let(:adjacency_matrix) {described_class.new(vertices)}
      let(:result_matrix) { [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]}

      it('initialize the matrix') {expect(adjacency_matrix.matrix).to eq(result_matrix)}
    end
  end

  describe '#add_edge' do
    let(:adjacency_matrix) {described_class.new(vertices)}
    let(:result_matrix) { [[0,0,0,0], [0,0,0,1], [0,0,0,0], [0,1,0,0]]}

    before {adjacency_matrix.add_edge(1, 3)}

    context 'when add edge' do
      it("change the value of matrix") {expect(adjacency_matrix.matrix).to eq(result_matrix)}
      it("change the dree of each vertex") {expect(vertices.map(&:degree)).to eq([0,1,0,1])}
    end
  end

  describe '#get_adjacencies' do
    let(:adjacency_matrix) {described_class.new(vertices)}

    before {adjacency_matrix.add_edge(1, 3)}

    it('returns the adjacencies') {expect(adjacency_matrix.get_adjacencies(1)).to eq([vertex_D])}

  end
end