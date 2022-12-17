class Vertex
  attr_reader :label, :degree

  def initialize(label)
    raise ArgumentError.new('Label must be a String') unless label.instance_of?(String)
    raise ArgumentError.new('Blank label not allowed') if label.strip == ''

    @label = label
    @degree = 0
  end

  def add_degree
    @degree += 1
  end
end
