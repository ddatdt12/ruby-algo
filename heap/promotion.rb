class Heap
  def initialize(compare_symbol = :<, storage = [], &compare_fn)
    @heap = storage
    @size = 0
    initialize_compare(compare_symbol, &compare_fn)
  end

  attr_reader :size

  def empty?
    size == 0
  end

  def peak
    @heap[0]
  end

  def pop
    result = peak

    if size > 1
      @size -= 1
      @heap[0] = @heap[@size]
      rebalance_down(0)
    else
      @size = 0
    end

    @heap[@size] = nil

    result
  end

  def push(element)
    @heap[@size] = element
    @size += 1
    rebalance_up(size - 1)
    self
  end

  alias :<< :push

  def replace(element)
    @heap[0] = element
    rebalance_down(0)
  end

  def offer(element)
    if compare(peak, element)
      result = peak
      replace(element)
      result
    else
      element
    end
  end

  def clear
    @heap = []
    @size = 0
  end

  def to_a
    @heap.reject { |element| element.nil? }
  end

  private

  def initialize_compare(symbol, &fn)
    @compare = if block_given?
        fn
      elsif symbol == :< or symbol.nil?
        lambda { |a, b| a < b }
      elsif symbol == :>
        lambda { |a, b| a > b }
      else
        raise ArgumentError.new("The comparison symbol needs to be either :> or :<")
      end
  end

  def compare(a, b)
    @compare.call(a, b)
  end

  def rebalance_up(i)
    parent_i = parent(i)

    if has_parent(i) and compare(@heap[i], @heap[parent_i])
      @heap[i], @heap[parent_i] = @heap[parent_i], @heap[i]
      rebalance_up(parent_i)
    end
  end

  def rebalance_down(i)
    left_i = left(i)
    right_i = right(i)

    if has_left(i) and compare(@heap[left_i], @heap[i]) and (not has_right(i) or compare(@heap[left_i], @heap[right_i]))
      @heap[i], @heap[left_i] = @heap[left_i], @heap[i]
      rebalance_down(left_i)
    elsif has_right(i) and compare(@heap[right_i], @heap[i])
      @heap[i], @heap[right_i] = @heap[right_i], @heap[i]
      rebalance_down(right_i)
    end
  end

  def has_parent(i)
    i >= 1
  end

  def parent(i)
    ((i - 1) / 2).floor
  end

  def has_left(i)
    left(i) < size
  end

  def left(i)
    i * 2 + 1
  end

  def has_right(i)
    right(i) < size
  end

  def right(i)
    i * 2 + 2
  end
end

# Path: main.rb

n = gets.chomp.to_i
min_heap = Heap.new(:<)
max_heap = Heap.new(:>)
freqs = Array.new(10 ** 6, 0)
totalCost = 0
while n > 0
  inputs = gets.chomp.split.map(&:to_i)[1..-1]
  inputs.each do |x|
    freqs[x] += 1
    min_heap.push(x)
    max_heap.push(x)
  end

  min = min_heap.pop
  while freqs[min] == 0
    min = min_heap.pop
  end
  freqs[min] -= 1

  max = max_heap.pop
  while freqs[max] == 0
    max = max_heap.pop
  end
  freqs[max] -= 1

  totalCost += max - min
  n -= 1
end

puts totalCost
