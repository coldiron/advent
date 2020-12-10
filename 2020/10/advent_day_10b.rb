class Chargers
  attr_reader :chargers, :differences

  def initialize
    @memo = {}
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
    @chargers.sort!
  end

  def permutations(joltage)
    @memo[joltage] = 0
    if joltage == @chargers.max
      @memo[joltage] = 1
      return 1
    end

    paths = 0
    paths = paths_for_joltage(joltage + 1, paths)
    paths = paths_for_joltage(joltage + 2, paths)
    paths = paths_for_joltage(joltage + 3, paths)
    paths
  end

  def add_joltage_differences
    @chargers.length.times do |i|
      @differences.append @chargers[i + 1] - @chargers[i] unless @chargers[i + 1].nil?
    end
    @differences.sort!
  end

  private

  def has_charger?(joltage)
    @chargers.include? joltage
  end

  def add_charger(joltage)
    @chargers.append(joltage.to_i)
  end

  def paths_for_joltage(joltage, paths)
    if has_charger?(joltage)
      if @memo[joltage].nil?
        paths += permutations(joltage)
        @memo[joltage] = paths
      else
        paths += @memo[joltage]
      end
    end
    paths
  end
end

chargers = Chargers.new

chargers.from_file('input')

puts chargers.permutations(0).to_s
