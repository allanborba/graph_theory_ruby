require_relative "../util/stack"
require_relative "base_search"

class DepthFirstSearch < BaseSearch
  def search(graph, beginning, destination)
    base_structure = Stack.new
    super(graph, beginning, destination, base_structure)
  end
end
