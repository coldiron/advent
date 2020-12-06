class Passport
    REQUIRED_FIELDS = [
        :byr,
        :iyr,
        :eyr,
        :hgt,
        :hcl,
        :ecl,
        :pid
    ]

    @valid = true

    def initialize(fields)
        @fields = fields
        self.validate
    end

    def valid?
        @valid
    end

    private
    def validate
        @valid = true
        REQUIRED_FIELDS.each do |r|
            unless @fields.key?(r)
                @valid = false
            end
        end
    end
end


class PassportCollection
    def initialize
        @passports = []
        get_passports
    end

    def valid_count
        @passports.select(&:valid?).count
    end

    private 
    def get_passports
        file = File.open("input")
        rows = file.read.split("\n\n")
        file.close
        rows.each do |r|
            @passports << add_passport(r)
        end
    end

    def add_passport(entry)
        Passport.new(Hash[
            entry.split(' ').map do |pair|
                key, value = pair.strip.split(':',  2)
                [key.to_sym, value]
            end
        ])
    end
end

passports = PassportCollection.new

puts passports.valid_count