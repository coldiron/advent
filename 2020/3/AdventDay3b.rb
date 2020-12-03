class AdventDay3a
    TREE = '#'

    attr_reader :treesHit, :to_s

    def initialize(rise, run)
        @rise = rise
        @run = run
        @rows = getRows
        @treesHit = 0
        @to_s = ""

        self.toboggan!
    end

    private
    def toboggan!
        i = 0
        j = 0

        @rows.each do |row|
            if j % @rise == 0
                rowWithCursor = row.dup

                if i >= row.length - 1
                    i -= (row.length)
                end

                if isTree?(row[i])
                    @treesHit += 1
                    rowWithCursor[i] = "X"
                else
                    rowWithCursor[i] = "O"
                end

                @to_s += "#{row} #{rowWithCursor}\n"

                i += @run
            end
            j += 1
        end
        @to_s += "Rise: #{@rise}, Run: #{@run}, Trees hit: #{@treesHit}"
    end

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

route1 = AdventDay3a.new(-1, 1) 
route2 = AdventDay3a.new(-1, 3) 
route3 = AdventDay3a.new(-1, 5) 
route4 = AdventDay3a.new(-1, 7) 
route5 = AdventDay3a.new(-2, 1) 

treesProduct = (route1.treesHit * route2.treesHit * route3.treesHit * route4.treesHit * route5.treesHit)

puts treesProduct