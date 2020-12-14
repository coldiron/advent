class FerryComputer
  def initialize(program = [])
    @program = program
    @mem = {}
    @bitmask = []
  end

  def run
    @program.each do |instruction|
      if instruction.start_with? 'mask'
        @bitmask = instruction.split[2].chars
      else
        addresses = address_combinations(
          thirty_six_bit(instruction.split[0])
        ).map! { |address| address.to_i(2) }
        addresses.each do |address|
          @mem[address.to_i] = instruction.split[2].to_i
        end
      end
    end
  end

  def load_from_file(filename)
    @program = File.readlines(filename, chomp: true)
  end

  def sum_memory
    @mem.values.sum
  end

  private

  def thirty_six_bit(value)
    value.scan(/\d*/)
      .join
      .to_i
      .to_s(2)
      .rjust(36, '0')
  end

  def partially_masked(address)
    @bitmask.each_with_index do |bit, index|
      next if bit == '0'

      address[index] = bit
    end
    address
  end

  def address_combinations(address)
    partial_address = partially_masked(address).chars
    addresses = []
    bits_list = bit_combinations(@bitmask.count('X'))

    bits_list.each do |bits|
      current_address = ''
      bits = bits.chars
      x_index = 0
      partial_address.each do |bit|
        if bit == 'X'
          current_address += bits[x_index]
          x_index += 1
        else
          current_address += bit
        end
      end
      addresses.append(current_address)
    end
    addresses
  end

  def bit_combinations(bits)
    combinations = []
    (2**bits).times do |number|
      combinations.append(
        number
        .to_s(2)
        .rjust(bits, '0')
      )
    end
    combinations
  end
end

computer = FerryComputer.new

computer.load_from_file('input')

computer.run

puts computer.sum_memory
