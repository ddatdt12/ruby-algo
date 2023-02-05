def transform_expression(expression)
  operation_stack = []
  res = ""

  expression.split("").each do |ch|
    next if ch == "("

    if ch == ")"
      res += operation_stack.pop
    elsif ch >= "a" and ch <= "z"
      res += ch
    else
      operation_stack.push(ch)
    end
  end
  puts res
end

n = gets.chomp.to_i

for i in 1..n
  expression = gets.chomp
  puts transform_expression(expression)
end
