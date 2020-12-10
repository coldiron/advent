class XmasLight
  def initialize(_letters, _rules)
    @on = false
  end

  def on?
    @on
  end

  def off?
    !on?
  end

  def turn_on
    @on = true
  end

  def turn_off
    @on = false
  end

  def toggle
    on? ? turn_off : turn_on
  end
end

class XmasLights
  def initialize(x_size, y_size)
    @lights = Array.new(x_size) { Array.new(y_size) }
    @lights.each do |light|
      light.each do |l|
        l = XmasLight.new
      end
    end
    @instructions = []
  end

  def from_file(filename)
    file = File.open(filename)
    file.read.split("\n").each do |line|
      @instructions.append line
    end
    file.close
  end
end

strings.from_file('input')
