class Row
  attr_accessor :seats

  def initialize(seats = [])
    @seats = seats
  end
end

class Seat
  def initialize(type)
    @type = type
  end

  def to_s
    @type.to_s
  end

  def to_str
    to_s
  end

  def sit!
    @type = '#'
  end

  def stand!
    @type = 'L'
  end

  def floor?
    @type == '.'
  end

  def empty?
    !occupied?
  end

  def occupied?
    @type == '#'
  end
end

class Rows
  attr_reader :rows, :last_rows

  def initialize
    @rows = []
    @last_rows = []
    @seats_length = 0
  end

  def musical_chairs
    new_rows = Marshal.load(Marshal.dump(@rows)) # Using marshal to 'deep clone'

    @rows.each_with_index do |row, row_index|
      row.seats.each_with_index do |seat, seat_index|
        next if seat.floor?

        visible = visible_count(row_index, seat_index)
        new_rows[row_index].seats[seat_index].stand! if seat.occupied? && visible >= 5
        new_rows[row_index].seats[seat_index].sit! if seat.empty? && visible == 0
      end
    end
    @last_rows = Marshal.load(Marshal.dump(@rows))
    @rows = Marshal.load(Marshal.dump(new_rows))
  end

  def visible_count(row_index, seat_index)
    directions = [[-1, -1], [-1, 0], [-1, 1],
                  [ 0, -1],          [ 0, 1], # rubocop:disable all
                  [ 1, -1], [ 1, 0], [ 1, 1]] # rubocop:disable all
    count = 0
    directions.each do |direction| 
      count += 1 if visible_in_direction(row_index, seat_index, direction)
    end
    count
  end

  def visible_in_direction(row_index, seat_index, direction)
    visible = false
    until visible
      row_index += direction[0]
      seat_index += direction[1]
      break if outside_index?(row_index, seat_index)
      square = @rows[row_index].seats[seat_index]
      visible = true if square.occupied?
      break unless square.floor?
    end
    visible
  end

  def filled_seats
    count = 0
    @rows.each do |row|
      row.seats.each do |seat|
        count += 1 if seat.occupied?
      end
    end
    count
  end

  def to_s
    output = ''
    @rows.each do |row|
      row.seats.each do |seat|
        output += seat
      end
      output += "\n"
    end
    output
  end

  def to_str
    to_s
  end

  def from_file(filename)
    File.readlines(filename, chomp: true).map do |row|
      new_row = Row.new
      @seats_length = row.length
      row.split('').each do |seat|
        new_row.seats.append(Seat.new(seat))
      end
      @rows.append(new_row)
    end
  end

  def resolve_seating
    rounds = 0
    last_count = -1

    until filled_seats == last_count
      last_count = filled_seats
      musical_chairs
      rounds += 1
    end
  end

  private
  def outside_index?(i, j)
    i < 0 || i >= @rows.length || j < 0 || j >= @seats_length
  end
end

rows = Rows.new

rows.from_file('input')

rows.resolve_seating

puts "Final number of seats filled: #{rows.filled_seats}."
