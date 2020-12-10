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

  def to_s
    output  = 'Total differences:   ' + @differences.length.to_s + "\n"
    output += 'Total chargers:      ' + @chargers.length.to_s + "\n"
    output += '1 jolt differences:  ' + @differences.count(1).to_s + "\n"
    output += '3 jolt differences:  ' + @differences.count(3).to_s + "\n"
    output += '3j diffs * 1j diffs: ' + (@differences.count(3) * @differences.count(1)).to_s + "\n"
  end
end

chargers = Chargers.new

chargers.from_file('input')

chargers.sort_by_joltage

chargers.add_joltage_differences

puts chargers