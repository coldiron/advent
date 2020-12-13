class BusSchedule
  def initialize
    @buses = []
  end

  def calculate
    time = 0
    interval = 1
    @buses.each do |bus, offset|
      time += interval until (time + offset) % bus == 0
      interval *= bus
    end
    time
  end

  def load_from_file(filename)
    offset = 0
    File.readlines(filename, chomp: true)[1].split(',').each do |entry|
      unless entry == 'x'
        @buses.append([entry.to_i, offset])
      end
      offset += 1
    end
  end
end

buses = BusSchedule.new

buses.load_from_file('input')
puts buses.calculate
