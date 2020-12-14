class FerryDocker
  def initialize(program = [])
    @program = program
    @mem = {}
    @bitmask = []
  end

  def run
    @program.each do |instruction|
      if instruction.start_with? "mask"
        @bitmask = instruction.split[2].split('')
      else
        instruction = instruction.split
        @mem[instruction[0].scan(/\d*/).join.to_i] = bitmasked_value(instruction[2])
      end
    end
  end

  def sum_memory
    @mem.values.sum
  end

  def bitmasked_value(value)
    value = value.to_i.to_s(2).rjust(36, '0').split('')
    @bitmask.each_with_index do |bit, index|
      next if bit == 'X'
      value[index] = bit
    end
    value.join.to_i(2)
  end

  def load_from_file(filename)
    @program = File.readlines(filename, chomp: true)
  end
end

docker = FerryDocker.new

docker.load_from_file('input')

docker.run

puts docker.sum_memory