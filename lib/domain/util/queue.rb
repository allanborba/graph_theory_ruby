require_relative "stack"

class QueueFifo < Stack
  def add(value)
    node = { value: value, next: nil }
    length.zero? ? set_top(node) : bottom[:next] = node

    set_bottom(node)
    incress_length
  end
end
