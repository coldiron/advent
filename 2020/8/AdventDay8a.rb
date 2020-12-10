# frozen_string_literal: true

class GameConsole
  def initialize
    @instructions = []
    @instruction_positions_executed = []
    @current_instruction_position = 0
    @accumulator = 0
  end

  def execute_program
    program_broken = false

    until program_broken
      instruction = @instructions[@current_instruction_position]
      instruction = instruction.split(' ')
      value = instruction.last.to_i
      instruction = instruction.first

      puts @accumulator
      if @instruction_positions_executed.include?(@current_instruction_position)
        program_broken = true
      else
        @instruction_positions_executed.append(@current_instruction_position)
        puts "#{instruction} #{value}, pos: #{@current_instruction_position}"
        send(instruction.to_s, value)
      end
    end
  end

  def from_file(filename)
    get_program(filename)
  end

  private

  def acc(value)
    @accumulator += value
    @current_instruction_position += 1
  end

  def jmp(value)
    @current_instruction_position += value
  end

  def nop(_value)
    @current_instruction_position += 1
  end

  def get_program(filename)
    file = File.open(filename)
    @instructions = file.read.split("\n")
    file.close
  end
end

console = GameConsole.new

console.from_file('input')

console.execute_program
