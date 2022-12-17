require 'graph/core/graph'
require 'graph/core/vertex'

describe Graph do
  describe '#initialize' do
    context 'when the argument is not a number' do
      it {expect{described_class.new('A')}.to raise_error(ArgumentError, 'Max vertices must be a number')}
    end

    context 'when the argument number less then 1' do
      it {expect{described_class.new(0)}.to raise_error(ArgumentError, 'Max vertices must be equal or greater than one')}
    end
  end

  describe '#add_vertex' do
    let(:graph) {described_class.new(1)}


    context 'when the number of vertices exceed the max allowed' do
      before {graph.add_vertex('A')}

      it {expect{graph.add_vertex('B')}.to raise_error(ArgumentError, 'Max allowed vertices has been exceeded')}
    end

    context 'when the number of vertices is valid' do
      it('incress the vertices size') {expect{graph.add_vertex('A')}.to change(graph.vertices, :count).by(1)}
      it('get the index by label') {expect(graph.indexed_label['A']).to eq(0)}
    end
  end
end
