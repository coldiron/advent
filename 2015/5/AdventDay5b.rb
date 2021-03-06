class XmasString
  def initialize(letters, rules)
    @letters = letters
    @rules = rules
  end

  def nice?
    rules_followed = true
    @rules.each do |rule|
      rules_followed = send(rule) if rules_followed
    end
    rules_followed
  end

  def naughty?
    !nice?
  end

  private

  def has_repeating_pairs
    passes = false
    @letters.length.times do |i|
      if i < @letters.length - 3
        pattern = @letters.slice(i..i + 1)
        passes = true if @letters.slice(i + 2..).include? pattern
      end
      break if passes
    end
    passes
  end

  def repeats_one_apart
    passes = false
    @letters.length.times do |i|
      if i < @letters.length - 1 && @letters.slice(i).eql? @letters.slice(i + 2)
        passes = true
      end
    end
    passes
  end

  def contains_three_vowels
    count = 0
    @letters.dup.split('').each do |letter|
      count += 1 if %w[a e i o u].include? letter
    end
    count > 2
  end

  def contains_doubles
    letters = @letters.dup.split('')
    doubles = false
    i = 0
    while i < letters.length && doubles == false
      doubles = true if letters[i] == letters[i + 1]
      i += 1
    end
    doubles
  end

  def no_banned_strings
    banned = false
    %w[ab cd pq xy].each do |banned_string|
      banned ||= @letters.include? banned_string
    end
    !banned
  end
end

class XmasStrings
  attr_reader :strings

  def initialize(rules)
    @strings = []
    @rules = rules
  end

  def nice_count
    @strings.select(&:nice?).count
  end

  def from_file(filename)
    file = File.open(filename)
    file.read.split("\n").each do |line|
      @strings.append XmasString.new(line, @rules)
    end
    file.close
  end
end

strings = XmasStrings.new(%i[has_repeating_pairs repeats_one_apart])

strings.from_file('input')

puts strings.nice_count
