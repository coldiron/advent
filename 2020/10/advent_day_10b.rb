class Chargers
  def initialize
    # memoization dictionary. because each charger
    # has a unique joltage, we can use the joltage
    # as a key to reference the memoized value
    @memo = {}
    @chargers = []
  end

  def min
    @chargers.min
  end

  def from_file(filename)
    file = File.open(filename)
    file.read.split("\n").each do |joltage|
      @chargers.append(joltage.to_i)
    end
    file.close
    @chargers.append(0) # add airplane's outlet
    @chargers.sort!
    @chargers.append(@chargers.max + 3) # add device's built-in charger
  end

  def permutations(joltage)
    if joltage == @chargers.max
      @memo[joltage] = 1
      return 1
    end

    paths = 0
    paths = memoized_paths(joltage + 1, paths)
    paths = memoized_paths(joltage + 2, paths)
    memoized_paths(joltage + 3, paths)
  end

  private

  def memoized_paths(joltage, paths = 0)
    if @chargers.include?(joltage)
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

puts chargers.permutations(chargers.min).to_s
