class Stack
  attr_reader :top, :bottom, :length

  def initialize
    @top = nil
    @bottom = nil
    @length = 0
  end

  def add(value)
    node = { value: value, next: nil }
    if length == 0
      set_bottom(node)
    else
      node[:next] = top
    end

    set_top(node)
    incress_length
  end

  def remove
    return if length == 0

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

  private

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
