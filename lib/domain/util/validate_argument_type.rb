class ValidadeArgumentType
  def self.call(argument, type)
    raise ArgumentError, "The value #{argument} must be a #{type}" unless argument.instance_of? type
  end
end