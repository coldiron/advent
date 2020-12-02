class AdventDay1a
    def initialize
        puts floor(getInput)
    end

    private
    def floor(input)
        floor = 0
        input.split('').each do |char|
            char == '(' ? floor += 1 : floor -= 1
        end
        floor
    end

    def getInput
        file = File.open("input")
        input = file.read
        file.close
        input
    end
end

run = AdventDay1a.new