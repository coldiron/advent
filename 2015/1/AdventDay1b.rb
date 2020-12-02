class AdventDay1b
    def initialize
        puts position(getInput)
    end

    private
    def position(input)
        position = 0
        floor = 0
            input.split('').each do |char|
                unless floor < 0
                    position += 1
                    char == '(' ? floor += 1 : floor -= 1
                end
            end
        position
    end

    def getInput
        file = File.open("input")
        input = file.read
        file.close
        input
    end
end

run = AdventDay1b.new