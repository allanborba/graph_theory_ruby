class Queue
  attr_reader :first, :last, :length

  def initialize
    @first = nil
    @last = nil
    @length = 0
  end

  def add(value)
    node = { value: value, next: nil }
    if length == 0
      set_first(node)
    else
      last[:next] = node
    end

    set_last(node)
    incress_length
  end

  def remove
    return if length == 0

    item_to_remove = first

    if length == 1
      set_first(nil)
      set_last(nil)
    else
      set_first(first[:next])
    end

    decrease_length
    item_to_remove[:value]
  end

  def any?
    length > 0
  end

  private

  def set_first(node)
    @first = node
  end

  def set_last(node)
    @last = node
  end

  def incress_length
    @length += 1
  end

  def decrease_length
    @length -= 1
  end
end
