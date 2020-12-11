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

  def sitting_round
    new_rows = Marshal.load(Marshal.dump(@rows)) # Using marshal to 'deep clone'

    @rows.each_with_index do |row, row_index|
      row.seats.each_with_index do |seat, seat_index|
        adjacent = 0
        unless seat.floor?
          adjacent = check_adjacent(row_index, seat_index)
          if seat.occupied? && adjacent > 3
              new_rows[row_index].seats[seat_index].stand!
          end
          if seat.empty? && adjacent == 0
              new_rows[row_index].seats[seat_index].sit!
          end
        end
      end
    end
    @last_rows = Marshal.load(Marshal.dump(@rows))
    @rows = Marshal.load(Marshal.dump(new_rows))
  end

  def sitting_round_part_two
    new_rows = Marshal.load(Marshal.dump(@rows)) # Using marshal to 'deep clone'

    @rows.each_with_index do |row, row_index|
      row.seats.each_with_index do |seat, seat_index|
        unless seat.floor?
          visible = check_visible(row_index, seat_index)
          if seat.occupied? && visible >= 5
              new_rows[row_index].seats[seat_index].stand!
          end
          if seat.empty? && visible == 0
              new_rows[row_index].seats[seat_index].sit!
          end
        end
      end
    end
    @last_rows = Marshal.load(Marshal.dump(@rows))
    @rows = Marshal.load(Marshal.dump(new_rows))
  end

  # This is an absolute monstrosity that arose from debugging and i'm just not
  # going to bother changing it
  def check_visible(row_index, seat_index)
    visible = {} #used this to get into a bug, too lazy to change back
    checking_seat_index = seat_index.dup
    # Up
    ((row_index - 1).downto(0)).each do |i|
      if @rows[i].seats[checking_seat_index].occupied?
        visible[:up] = true
      end
      unless @rows[i].seats[checking_seat_index].floor?
        break
      end
    end
    # Up/Right
    checking_seat_index = seat_index.dup
    ((row_index - 1).downto(0)).each do |i|
      checking_seat_index += 1
      unless outside_index?(i, checking_seat_index)
        if @rows[i].seats[checking_seat_index].occupied?
          visible[:up_right] = true
        end
        unless @rows[i].seats[checking_seat_index].floor?
          break
        end
      end
    end
    checking_seat_index = seat_index.dup
    # Right
    (seat_index + 1..@seats_length - 1).each do |j|
      if @rows[row_index].seats[j].occupied?
        visible[:right] = true
      end
      unless @rows[row_index].seats[j].floor?
        break
      end
    end
    checking_seat_index = seat_index.dup
    # Right/Down
    (row_index + 1..@seats_length - 1).each do |i|
      checking_seat_index += 1
      unless outside_index?(i, checking_seat_index)
        if @rows[i].seats[checking_seat_index].occupied?
          visible[:right_down] = true
        end
        unless @rows[i].seats[checking_seat_index].floor?
          break
        end
      end
    end
    checking_seat_index = seat_index.dup
    # Down
    (row_index + 1..@rows.length - 1).each do |i|
      if @rows[i].seats[checking_seat_index].occupied?
        visible[:down] = true
      end
      unless @rows[i].seats[checking_seat_index].floor?
        break
      end
    end
    checking_seat_index = seat_index.dup
    # Down/Left
    (row_index + 1..@seats_length - 1).each do |i|
      checking_seat_index -= 1
      unless outside_index?(i, checking_seat_index)
        if @rows[i].seats[checking_seat_index].occupied?
          visible[:down_left] = true
        end
        unless @rows[i].seats[checking_seat_index].floor?
          break
        end
      end
    end
    checking_seat_index = seat_index.dup
    # Left
    ((seat_index - 1).downto(0)).each do |j|
      unless outside_index?(row_index, j)
        if @rows[row_index].seats[j].occupied?
          visible[:left] = true
        end
        unless @rows[row_index].seats[j].floor?
          break
        end
      end
    end
    checking_seat_index = seat_index.dup
    # Left/Up
    ((row_index - 1).downto(0)).each do |i|
      checking_seat_index -= 1
      unless outside_index?(i, checking_seat_index)
        if @rows[i].seats[checking_seat_index].occupied?
          visible[:leftup] = true
        end
        unless @rows[i].seats[checking_seat_index].floor?
          break
        end
      end
    end
    count = 0
    #puts visible.inspect
    visible.each_value do |v|
      count +=1
    end
    count
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
    i < 0 || i >= @rows.length || j < 0 || j >= @seats_length
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
end

rows = Rows.new

rows.from_file('input')

rounds = 0
finished = false
last_count = -1
until rows.filled_seats == last_count
  last_count = rows.filled_seats
  rows.sitting_round_part_two
  rounds += 1
end
puts rows.filled_seats
puts rounds

