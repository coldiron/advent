class Chargers
  attr_reader :chargers, :differences

  def initialize
    @chargers = []
    @differences = []
  end

  def from_file(filename)
    file = File.open(filename)
    @chargers = file.read.split("\n").each do |joltage|
      add_charger(joltage)
    end
    file.close
    @chargers = @chargers.map { |charger| charger.to_i } # for some reason I get an array of strings even if I set values with to_i
    @chargers.append(@chargers.max + 3) # add device's built-in charger
    @chargers.append(0) # add airplane's outlet
  end

  def permutations_memo(joltage)
    perms = {}
    permutations(joltage, perms)
  end

  def permutations(joltage, memo)
    memo[joltage] = 0
    if joltage == @chargers.max
      memo[joltage] = 1
      return 1
    end

    paths = 0
    if has_charger?(joltage + 1)
      if memo[joltage + 1].nil?
        paths += permutations(joltage + 1, memo)
        memo[joltage + 1] = paths
      else
        paths += memo[joltage + 1]
      end
    end
    if has_charger?(joltage + 2)
      if memo[joltage + 2].nil?
        paths += permutations(joltage + 2, memo)
        memo[joltage + 2] = paths
      else
        paths += memo[joltage + 2]
      end
    end
    if has_charger?(joltage + 3)
      if memo[joltage + 3].nil?
        paths += permutations(joltage + 3, memo)
        memo[joltage + 3] = paths
      else
        paths += memo[joltage + 3]
      end
    end
    paths
  end

  def has_charger?(joltage)
    @chargers.include? joltage
  end

  def add_charger(joltage)
    @chargers.append(joltage.to_i)
  end

  def sort_by_joltage
    @chargers.sort!
  end

  def add_joltage_differences
    @chargers.length.times do |i|
      @differences.append @chargers[i + 1] - @chargers[i] unless @chargers[i + 1].nil?
    end
    @differences.sort!
  end
end

chargers = Chargers.new

chargers.from_file('input')

chargers.sort_by_joltage

puts chargers.permutations_memo(0).to_s
