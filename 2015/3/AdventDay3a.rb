# frozen_string_literal: true

class AdventDay3a
  def initialize
    @x = 0
    @y = 0
    @visits = [[0, 0]]
    @instructions = getInput
  end

  def run
    puts followInstructions
  end

  private

  def followInstructions
    @instructions.split('').each do |instruction|
      move(instruction)
    end
    @visits.length
  end

  def move(instruction)
    case instruction
    when '^'
      @y += 1
      countIfUnvisited
    when 'v'
      @y -= 1
      countIfUnvisited
    when '<'
      @x -= 1
      countIfUnvisited
    when '>'
      @x += 1
      countIfUnvisited
    end
  end

  def countIfUnvisited
    @visits.append([@x, @y]) unless @visits.include?([@x, @y])
  end

  def getInput
    file = File.open('input')
    input = file.read
    file.close
    input
  end
end

run = AdventDay3a.new
run.run
