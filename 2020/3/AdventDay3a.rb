class AdventDay3a
    TREE = '#'

    attr_reader :treesHit, :to_s

    def initialize(rise, run)
        @rise = rise      # Rise component of slope
        @run = run        # Run component of slope
        @rows = getRows   # Rows of trees
        @treesHit = 0     # Counter of trees hit while tobogganing along slope
        @to_s = ""

        self.toboggan!
    end

    private
    def toboggan!
        i = 0

        @rows.each do |row|
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

route = AdventDay3a.new(-1, 3) 
puts route