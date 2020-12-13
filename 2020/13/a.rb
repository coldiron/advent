class BusSchedule
  def initialize
    @buses = []
    @departures = {}
    @earliest_departure = 0
  end

  def calculate_departures
    @buses.each do |bus|
      time = 0
      until time >= @earliest_departure
        time += bus
      end
      @departures[bus] = time
    end
  end

  def best_departure
    best_so_far = [nil, nil]
    @departures.each do |bus, time|
      if best_so_far[1].nil? || best_so_far[1] > time
        best_so_far = [bus, time]
      end
    end
    best_so_far
  end

  def answer
    best = best_departure
    (best[1] - @earliest_departure) * best[0]
  end

  def load_from_file(filename)
    File.readlines(filename, chomp: true).each do |line|
      if @earliest_departure == 0
        @earliest_departure = line.to_i
      else
        line.split(',').each do |entry| 
          @buses.append(entry.to_i) unless entry == 'x'
        end
      end
    end
  end
end

buses = BusSchedule.new

buses.load_from_file('input')

buses.calculate_departures

puts buses.answer