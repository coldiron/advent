class AdventDay3a
    TREE = '#'
    SNOW = '.'

    attr_reader :treesHit

    def initialize(rise, run)
        @rise = rise      # Rise component of slope
        @run = run        # Run component of slope
        @rows = getRows   # Rows of trees
        @treesHit = 0     # Counter of trees hit while tobogganing along slope
    end

    def toboggan!
        i = 0

        @rows.each do |row|
            if i > row.length
                i -= (row.length)
            end

            if isTree?(row[i])
                @treesHit += 1
            end
            puts row

            i+= @run
        end
    end

    private
    def isTree?(j)
        j == TREE
    end

    def getRows
        file = File.open("input")
        rows = file.read.split("\n")
        file.close
        rows
    end
end

route = AdventDay3a.new(-1, 3) 

route.toboggan!

puts "Trees hit: #{route.treesHit}"