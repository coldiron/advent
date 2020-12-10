# frozen_string_literal: true

class AdventDay2b
  def initialize
    puts totalRequiredRibbon(getInput)
  end

  private

  def totalRequiredRibbon(input)
    total = 0
    input.split("\n").each do |package|
      total += requiredRibbon(package.split('x').map(&:to_i))
    end
    total
  end

  def requiredRibbon(package)
    l = package[0]
    w = package[1]
    h = package[2]
    package.sort!
    volume(l, w, h) + 2 * (package[0] + package[1])
  end

  def volume(l, w, h)
    l * w * h
  end

  def getInput
    file = File.open('input')
    input = file.read
    file.close
    input
  end
end

run = AdventDay2b.new
