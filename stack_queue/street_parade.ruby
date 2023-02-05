def rearrange_trucks(arr)
  side_streets = []
  res = []
  arr.each_with_index do |val, i|
    if i != arr.length - 1
      nextVal = arr[i + 1]
    end

    last_mobile_in_side = side_streets[-1]
    if last_mobile_in_side != nil && last_mobile_in_side < val
      current = side_streets.pop
      if res.any? && current - res[-1] > 1
        return "no"
      end
      res.push(current)
      redo
    end

    if nextVal != nil and val > nextVal
      side_streets.push(val)
    else
      if res.any? && val - res[-1] > 1
        return "no"
      end
      res.push(val)
    end
  end

  return "yes"
end

loop do
  n = gets.chomp.to_i
  break if n == 0
  arr = gets.chomp.split.map(&:to_i)
  puts rearrange_trucks arr
end
