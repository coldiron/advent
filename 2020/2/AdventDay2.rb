class AdventDay2
    def initialize
        puts count
    end

    private
    def count
        count = 0
        count2 = 0
        rows = getRows
        for row in rows do
            if isValid?(row)
                count +=1
            end
        end
        count
    end

    def isValid?(row)
        min = row.match(/\d*-\d*/)[0].split("-")[0].to_i
        max = row.match(/\d*-\d*/)[0].split("-")[1].to_i
        character = row.match(/[a-zA-Z]/)[0]
        password = row.split(": ")[1].to_s

        charCount = password.count(character)

        charCount >= min && max >= charCount
    end

    
    def getRows
        file = File.open("input")
        rows = file.read.split("\n")
        file.close
        rows
    end
end

adv = AdventDay2.new 