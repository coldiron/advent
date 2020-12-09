class AirplaneSeat
  ROW_MIN = 0
  ROW_MAX = 127
  COL_MIN = 0
  COL_MAX = 7

  def initialize(spec = '')
    @row_range = { min: ROW_MIN, max: ROW_MAX }
    @col_range = { min: COL_MIN, max: COL_MAX }
    @spec = spec
  end

  private

  def upper_half(row_or_col); end

  def parse_seat_spec; end
end

class AirplaneSeats
end
