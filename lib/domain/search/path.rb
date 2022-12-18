class Path
  attr_reader :path

  def initialize
    @path = {}
  end

  def connect(before, after)
    path[before] = after
  end

  def generate(beginning, destination)
    result = []
    node = destination

    while node != beginning && !path[node].nil?
      result << node
      node = path[node]
    end

    result << node

    result.reverse
  end
end
