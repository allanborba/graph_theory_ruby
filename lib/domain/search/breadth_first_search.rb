require_relative "../util/queue"
require_relative "base_search"

class BreadthFristSearch < BaseSearch
  def search(graph, beginning, destination)
    base_structure = Queue.new
    super(graph, beginning, destination, base_structure)
  end
end
