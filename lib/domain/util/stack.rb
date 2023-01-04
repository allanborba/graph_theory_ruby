class Stack
  attr_reader :top, :bottom, :length

  def initialize
    @top = nil
    @bottom = nil
    @length = 0
  end

  def add(value)
    node = { value: value, next: nil }
    length.zero? ? set_bottom(node) : node[:next] = top

    set_top(node)
    incress_length
  end

  def remove
    return if length.zero?

    item_to_remove = top

    if length == 1
      set_top(nil)
      set_bottom(nil)
    else
      set_top(top[:next])
    end

    decrease_length
    item_to_remove[:value]
  end

  def any?
    length > 0
  end

  protected

  def set_top(node)
    @top = node
  end

  def set_bottom(node)
    @bottom = node
  end

  def incress_length
    @length += 1
  end

  def decrease_length
    @length -= 1
  end
end
