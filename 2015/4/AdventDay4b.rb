require 'digest'

class AdventDay4b
    def initialize
        @input = 'yzbqklnj'
        @suffix = 0
    end

    def run
        until Digest::MD5.hexdigest(@input + @suffix.to_s)[0..5] == '000000'
            @suffix += 1
        end
        puts @suffix
        puts Digest::MD5.hexdigest(@input + @suffix.to_s)
    end
end

run = AdventDay4b.new
run.run