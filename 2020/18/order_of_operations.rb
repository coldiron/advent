def calculate(string)
  parenth = string.match(/\([^()]*[^()]*\)/).to_s
  until string.scan(/[()]/).first.nil?
    string.gsub!("#{parenth}", reduce(parenth).to_s)
    parenth = string.match(/\([^()]*[^()]*\)/).to_s
  end

  reduce(string).to_s
end

def reduce(string)
  string = string.gsub(/[()]/, '')
  expression = ''
  string.each_char.with_index do |char, index|
    expression += char
    if string[index + 1].nil?
      expression.gsub!(expression, eval(expression).to_s) 
      break
    end
    if operators.include?(string[index + 1]) && has_operator(expression)
      expression.gsub!(expression, eval(expression).to_s) 
      next
    end
  end

  expression
end

def has_operator(string)
  string.include?(operators[0]) || string.include?(operators[1])
end

def operators
  ['+', '*']
end

equations = File.readlines('input', chomp: true).map! { |line|
  line.gsub(/\s+/, '')
}

sum = 0

equations.each do |equation|
  sum += calculate(equation).to_i
end

p sum
