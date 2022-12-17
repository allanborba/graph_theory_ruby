class Vertex
  attr_reader :label

  def initialize(label)
    raise ArgumentError.new('Blank label not allowed') if !label || label.strip == ''

    @label = label
  end
end
