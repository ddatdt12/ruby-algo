class Heap
  def initialize
    @heap = []
  end

  def push(x)
    @heap.push(x)
    heapify(@heap.size - 1)
  end

  def pop
    return nil if @heap.empty?
    return @heap.shift if @heap.size == 1
    top = @heap[0]

    @heap[0] = @heap.pop
    down(0)
    top
  end

  def size
    @heap.size
  end

  def empty?
    @heap.empty?
  end

  def top
    @heap[0]
  end

  private

  def heapify(i)
    while i > 0
      p = (i - 1) / 2
      break if @heap[p] <= @heap[i]
      @heap[p], @heap[i] = @heap[i], @heap[p]
      i = p
    end
  end

  def down(i)
    while i < @heap.size
      l = 2 * i + 1
      r = 2 * i + 2
      break if l >= @heap.size
      if r >= @heap.size
        j = l
      else
        j = @heap[l] <= @heap[r] ? l : r
      end
      break if @heap[i] <= @heap[j]
      @heap[i], @heap[j] = @heap[j], @heap[i]
      i = j
    end
  end

  def to_s
    @heap.to_s
  end
end

# Path: main.rb

# n = gets.to_i
# m = gets.split.map(&:to_i)[0...n]
# m.each do |x|
#   heap.push(x)
# end

# while heap.size > 0
#   print heap.pop, " "
# end

loop do
  n = gets.to_i
  break if n == 0
  heap = Heap.new
  m = gets.split.map(&:to_i)[0...n]
  m.each do |x|
    heap.push(x)
  end
  cost = 0
  while heap.size > 1
    x = heap.pop
    y = heap.pop
    cost += x + y
    heap.push(x + y)
  end
  puts cost
end
