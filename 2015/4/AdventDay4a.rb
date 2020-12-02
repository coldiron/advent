require 'digest'

class AdventDay4a
    def initialize
        @input = 'yzbqklnj'
        @suffix = 0
    end

    def run
        until Digest::MD5.hexdigest(@input + @suffix.to_s)[0..4] == '00000'
            @suffix += 1
        end
        puts @suffix
    end
end

run = AdventDay4a.new
run.run