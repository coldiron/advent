
# def checkPairs(numbers, firstPos, secondPos) 
#     if((numbers[firstPos].to_i + numbers[secondPos].to_i) == 2020)
#         numbers[firstPos] * numbers[secondPos]
#     else
#         if(secondPos < numbers.length() - 1)
#             checkPairs(numbers, firstPos, (secondPos + 1))
#         else
#             checkPairs(numbers, firstPos + 1, 0)
#         end
#     end
# end

def correct(a, b, c) 
    a + b + c == 2020
end

def checkPairs(numbers)
    a = 0
    b = 0
    c = 0

    until a == numbers.length - 1 do
        until b == numbers.length - 1 do
            until c == numbers.length - 1 do
                if correct(numbers[a], numbers[b], numbers[c])
                    return numbers[a] * numbers[b] * numbers[c] 
                end
                c+=1
            end
            b+=1
            c = 0
        end
        a += 1
        b = 0
        c = 0
    end
end

file = File.open("input")

numbers = file.read.split

numbers = numbers.map(&:to_i)

file.close

puts checkPairs(numbers)