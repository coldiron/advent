class AdventDay3b
    def initialize
        @x1 = 0
        @x2 = 0
        @y1 = 0
        @y2 = 0
        @visits = [[0 ,0]] 
        @instructions = getInput
    end

    def run
        puts followInstructions
    end

    private
    def followInstructions
        @instructions.scan(/../).each do |instructions|
            puts instructions.inspect
            move(instructions[0], 1)
            move(instructions[1], 2)
        end
        @visits.length
    end

    def move(instruction, actor)
        case actor
        when 1
            case instruction
            when '^'
                @y1 += 1
                countIfUnvisited(1)
            when 'v'
                @y1 -= 1
                countIfUnvisited(1)
            when '<'
                @x1 -= 1
                countIfUnvisited(1)
            when '>'
                @x1 += 1
                countIfUnvisited(1)
            end
        when 2
            case instruction
            when '^'
                @y2 += 1
                countIfUnvisited(2)
            when 'v'
                @y2 -= 1
                countIfUnvisited(2)
            when '<'
                @x2 -= 1
                countIfUnvisited(2)
            when '>'
                @x2 += 1
                countIfUnvisited(2)
            end
        end
    end

    def countIfUnvisited(actor)
        case actor
        when 1
            unless @visits.include?([@x1, @y1])
                @visits.append([@x1, @y1])
            end
        when 2
            unless @visits.include?([@x2, @y2])
                @visits.append([@x2, @y2])
            end
        end
    end

    def getInput
        file = File.open("input")
        input = file.read
        file.close
        input
    end
end

run = AdventDay3b.new
run.run