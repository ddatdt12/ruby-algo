def ferry_loading_iii(cars, max_car_cnt, across_time)
  location = "left"
  t = 0
  left_bank = []
  right_bank = []
  ans = {}
  cars.each do |req|
    ans[req[:time]] = 0
  end

  while cars.any? and cars[0][:time] == 0
    car = cars.shift
    if car[:location] == "left"
      left_bank.push(car)
    else
      right_bank.push(car)
    end
  end

  while cars.any? or left_bank.any? or right_bank.any?
    cars_in_ferry = []
    if location == "left"
      while cars_in_ferry.length < max_car_cnt and left_bank.any?
        cars_in_ferry.push(left_bank.shift)
      end
    else
      while cars_in_ferry.length < max_car_cnt and right_bank.any?
        cars_in_ferry.push(right_bank.shift)
      end
    end

    if cars_in_ferry.any?
      location = location == "left" ? "right" : "left"
      t += across_time
    end
    # Save car already cross river in answer with time
    while cars_in_ferry.any?
      car = cars_in_ferry.shift
      ans[car[:time]] = t
    end

    while cars.any? and cars[0][:time] <= t
      car = cars.shift
      if car[:location] == "left"
        left_bank.push(car)
      else
        right_bank.push(car)
      end
    end
  end

  puts "Answer : " + ans.values.join(" ")
end

testcases = gets.chomp.to_i

while testcases != 0
  line2 = gets.chomp.split.map(&:to_i)
  max_car_cnt = line2[0]
  across_time = line2[1]
  car_cnt = line2[2]
  cars = []
  while car_cnt != 0
    input = gets.chomp.split
    cars.push({ time: input[0].to_i, location: input[1] })
    car_cnt -= 1
  end

  ferry_loading_iii(cars, max_car_cnt, across_time)
  testcases -= 1
end
