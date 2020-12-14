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
        addresses = address_combinations(thirty_six_bit(instruction.split[0]))
                    .map! { |address| address.to_i(2) }

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
    addresses = []
    address = partially_masked(address)
    bits_list = %w[0 1].repeated_permutation(address.count('X')).to_a

    bits_list.each do |bits|
      addresses.append(floating_bitmasked_address(address, bits))
    end
    addresses
  end

  def floating_bitmasked_address(address, bits)
    current_address = ''
    x_index = 0
    address.chars.each do |current_bit|
      if current_bit == 'X'
        current_address += bits[x_index]
        x_index += 1
      else
        current_address += current_bit
      end
    end
    current_address
  end
end

computer = FerryComputer.new

computer.load_from_file('input')

computer.run 

puts computer.sum_memory
