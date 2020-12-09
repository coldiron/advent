class XmasStream
  attr_reader :first_invalid_entry

  def initialize(preamble_size)
    @first_invalid_entry = 0
    @numbers = []
    @pos = preamble_size.dup
    @preamble_size = @pos.dup
  end

  def find_set_that_sums_to(number)
    size = 2
    while size < @numbers.length
      while @pos < @numbers.length
        set = last_n_numbers(size)
        return set if set.sum == number

        @pos += 1
      end
      @pos = @preamble_size.dup
      size += 1
    end
  end

  def from_file(filename)
    get_data(filename)
  end

  def find_invalid_entry
    @pos += 1 while valid_two_sum?(@numbers[@pos])

    @first_invalid_entry = @numbers[@pos]
  end

  def valid_two_sum?(number)
    last_n = last_n_numbers(@preamble_size)

    last_n.each do |i|
      last_n.each do |j|
        return true  if i + j == number
      end
    end
    false
  end

  def last_n_numbers(n)
    @numbers.dup[(@pos - n)..@pos]
  end

  private

  def get_data(filename)
    file = File.open(filename)
    @numbers = file.read.split("\n").map do |number|
      number.to_i
    end
    file.close
  end
end

data = XmasStream.new(25)

data.from_file('input')

data.find_invalid_entry

puts data.first_invalid_entry

set = data.find_set_that_sums_to(data.first_invalid_entry)

puts set.min + set.max
