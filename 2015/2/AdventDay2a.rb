# frozen_string_literal: true

class AdventDay2a
  def initialize
    puts totalRequiredPaper(getInput)
  end

  private

  def totalRequiredPaper(input)
    total = 0
    input.split("\n").each do |package|
      total += requiredPaper(package.split('x'))
    end
    total
  end

  def requiredPaper(package)
    l = package[0].to_i
    w = package[1].to_i
    h = package[2].to_i
    area(l, w, h) + smallestSide(l, w, h)
  end

  def area(l, w, h)
    2 * (sideArea(l, w) + sideArea(l, h) + sideArea(w, h))
  end

  def sideArea(l, w)
    l * w
  end

  def smallestSide(l, w, h)
    [sideArea(l, w), sideArea(l, h), sideArea(w, h)].min
  end

  def getInput
    file = File.open('input')
    input = file.read
    file.close
    input
  end
end

run = AdventDay2a.new
