def correct(a, b, c)
  a + b + c == 2020
end

def check_pairs(numbers)
  a = 0
  b = 0
  c = 0

  until a == numbers.length - 1
    until b == numbers.length - 1
      until c == numbers.length - 1
        return numbers[a] * numbers[b] * numbers[c] if correct(numbers[a], numbers[b], numbers[c])

        c += 1
      end
      b += 1
      c = 0
    end
    a += 1
    b = 0
    c = 0
  end
end

file = File.open('input')
numbers = file.read.split
numbers = numbers.map(&:to_i)
file.close

puts check_pairs(numbers)
