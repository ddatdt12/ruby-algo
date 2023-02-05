def run_server(requests, queue_max_capacity)
  queue = []
  t = 0

  # ans is hash map
  ans = {}
  requests.each do |req|
    ans[req[:time]] = -1
  end
  while queue.any? or requests.any?
    if queue.any?
      current_req = queue.shift
    else
      current_req = requests.shift
    end

    if t < current_req[:time]
      t = current_req[:time]
    end

    t += current_req[:duration]
    ans[current_req[:time]] = t

    loop do
      if requests.length == 0 or requests[0][:time] >= t
        break
      end

      req = requests.shift
      if queue.length < queue_max_capacity
        queue.push(req)
      end
    end
  end

  puts ans.values.join(" ")
end

nb = gets.chomp.split.map(&:to_i)
n = nb[0]
b = nb[-1]
requests = []
while n != 0
  input = gets.chomp.split.map(&:to_i)
  requests.push({ time: input[0], duration: input[1] })
  n -= 1
end

run_server(requests, b)
