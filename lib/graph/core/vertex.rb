class Vertex
  attr_reader :label

  def initialize(label)
    raise ArgumentError.new('Label must be a String') unless label.instance_of?(String)
    raise ArgumentError.new('Blank label not allowed') if label.strip == ''

    @label = label
  end
end
