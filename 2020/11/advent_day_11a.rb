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
    @row_length = 0
  end

  def sitting_round
    new_rows = Marshal.load(Marshal.dump(@rows)) # Using marshal to 'deep clone'

    @rows.each_with_index do |row, row_index|
      row.seats.each_with_index do |seat, seat_index|
        adjacent = 0
        unless seat.floor?
          adjacent = check_adjacent(row_index, seat_index)
          if seat.occupied? && adjacent > 3
#              puts "Standing, adj: #{adjacent}"
              new_rows[row_index].seats[seat_index].stand!
          end
          if seat.empty? && adjacent == 0
#              puts "Sitting, adj: #{adjacent}"
              new_rows[row_index].seats[seat_index].sit!
          end
        end
      end
    end
    @last_rows = Marshal.load(Marshal.dump(@rows))
    @rows = Marshal.load(Marshal.dump(new_rows))
  end

  def filled_seats
    count = 0
    @rows.each do |row|
      row.seats.each do |seat|
        if seat.occupied?
          count += 1
        end
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

  def check_adjacent(row_index, seat_index)
    adjacent = 0

    (row_index - 1..row_index + 1).each do |i|
      (seat_index - 1..seat_index + 1).each do |j|
        unless outside_index?(i, j)
          if @rows[i].seats[j].occupied?
            adjacent += 1 unless(i == row_index && j == seat_index)
          end
        end
      end
    end
    adjacent
  end

  def outside_index?(i, j)
    i < 0 || i >= @rows.length || j < 0 || j >= @row_length
  end

  def from_file(filename)
    File.readlines(filename, chomp: true).map do |row|
      new_row = Row.new
      @row_length = row.length
      row.split('').each do |seat|
        new_row.seats.append(Seat.new(seat))
      end
      @rows.append(new_row)
    end
  end
end

rows = Rows.new

rows.from_file('input')

rounds = 0
finished = false
last_count = 0
until finished
  last_count = rows.filled_seats
  rows.sitting_round
  rounds += 1
  new_count = rows.filled_seats
  #puts "#{last_count}, #{new_count}"
  #puts rows
  #sleep 0.1
  finished = true if last_count == new_count
end
puts rows.filled_seats
puts rounds

