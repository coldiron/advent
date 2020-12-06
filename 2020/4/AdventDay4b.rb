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

    # Kinda hacky but allows slightly safer usage of send()
    ALLOWED_FIELDS = REQUIRED_FIELDS.dup.append(:cid)

    def initialize(fields)
        @valid = true
        @fields = fields
        self.validate
        puts @fields.inspect
    end

    def valid?
        @valid
    end

    private
    def validate
        REQUIRED_FIELDS.each do |r|
            unless @fields.key?(r)
                @valid = false
            end
        end

        if @valid
            @fields.each_key do |key|
                if ALLOWED_FIELDS.include?(key) 
                    unless send("validate_#{key}")
                        @valid = false
                    end
                end
            end
        end
    end

    def validate_byr
        @fields[:byr].to_i.between?(1920, 2002)
    end

    def validate_iyr
        @fields[:iyr].to_i.between?(2010, 2020)
    end

    def validate_eyr
        @fields[:eyr].to_i.between?(2020, 2030)
    end

    def validate_hgt
        validated = false

        hgt = @fields[:hgt].dup
        units = hgt[/\D\D/]
        value = hgt[/\d*/].to_i

        if(units == 'in')
            validated = value.between?(59, 76)
        end
        if(units == 'cm')
            validated = value.between?(150, 193)
        end
        validated
    end

    def validate_hcl
        /\A[#]([A-Fa-f]|\d){6}\z/.match?(@fields[:hcl])
    end

    def validate_ecl
        %w(amb blu brn gry grn hzl oth).include?(@fields[:ecl])
    end

    def validate_pid
        /\A\d{9}\z/.match?(@fields[:pid]) 
    end
    
    def validate_cid
        true
    end
end


class PassportCollection
    def initialize
        @passports = []
    end

    def valid_count
        @passports.select(&:valid?).count
    end

    def from_file(filename)
        file = File.open(filename)
        rows = file.read.split("\n\n")
        file.close
        rows.each do |r|
            @passports << add_passport(r)
        end
    end

    private
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
passports.from_file("input")

puts passports.valid_count