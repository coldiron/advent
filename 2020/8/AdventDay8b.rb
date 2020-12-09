class GameConsole
  def initialize
    @instructions = []
    @instruction_positions_executed = []
    @current_instruction_position = 0
    @accumulator = 0
    @program_broken = false
  end

  def execute_program
    until @current_instruction_position >= @instructions.length
      instruction = @instructions[@current_instruction_position]
      instruction = instruction.split(' ')
      value = instruction.last.to_i
      instruction = instruction.first

      puts @accumulator
      if @instruction_positions_executed.include?(@current_instruction_position)
        @program_broken = true
        @accumulator = 0
        @current_instruction_position = 0
        @instruction_positions_executed = []
        break
      else
        @instruction_positions_executed.append(@current_instruction_position)
        send(instruction.to_s, value)
      end
    end
  end

  def fix_instructions
    count = 0
    @instructions.each do |instruction|
      if instruction.start_with?('nop') && @program_broken
        instruction.gsub!('nop', 'jmp')
        execute_program
        instruction.gsub!('jmp', 'nop') if @program_broken
        count += 1
      end
    end
    if @program_broken
      @instructions.each do |instruction|
        if instruction.start_with?('jmp') && @program_broken
          instruction.gsub!('jmp', 'nop')
          execute_program
          instruction.gsub!('nop', 'jmp') if @program_broken
          count += 1
        end
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

console.from_file('input_fixed')
console.execute_program
console.fix_instructions
