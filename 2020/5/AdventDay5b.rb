class AirplaneSeat
  attr_reader :id, :to_s

  def initialize(spec = '')
    @rows = Array.new(128)
    @cols = Array.new(8)
    @spec = spec
    initialize_seats
    parse_spec
    create_id
    @to_s = "Seat \##{@id} - #{@spec} - Row: #{row}, Col: #{col}" 
  end

  def to_str
    to_s
  end

  def row
    @rows[0]
  end

  def col
    @cols[0]
  end

  private

  def create_id
    @id = row * 8 + col
  end

  def initialize_seats
    row = 0
    while row < 128
      @rows[row] = row
      row += 1
    end
    col = 0
    while col < 8
      @cols[col] = col
      col += 1
    end
  end

  def partition_rows_lower
    @rows.slice!(@rows.length / 2, @rows.length - 1)
  end

  def partition_rows_upper
    @rows.slice!(0, @rows.length / 2)
  end

  def partition_cols_upper
    @cols.slice!(@cols.length / 2, @cols.length - 1)
  end

  def partition_cols_lower
    @cols.slice!(0, @cols.length / 2)
  end

  def parse_spec
    @spec.split('').each do |direction|
      case direction
      when 'F'
        partition_rows_lower
      when 'B'
        partition_rows_upper
      when 'R'
        partition_cols_lower
      when 'L'
        partition_cols_upper
      end
    end
  end
end

class AirplaneSeats
  def initialize
    @seats = []
  end

  def from_file(filename)
    get_seats(filename)
  end

  def to_s
    output = ""
    @seats.each do |seat|
      output += seat.to_s + "\n"
    end
    output
  end

  def to_str
    to_s
  end

  def max_id
    @seats.map do |seat|
      seat.id
    end.max
  end

  private

  def get_seats(filename)
    file = File.open(filename)
    seats = file.read.split("\n")
    file.close
    seats.each do |seat|
      @seats << add_seat(seat)
    end
  end

  def add_seat(seat)
    AirplaneSeat.new(seat)
  end
end

seats = AirplaneSeats.new
seats.from_file('input')
puts seats.max_id.to_s