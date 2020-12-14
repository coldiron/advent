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

  def calculate_recursive(time = 0, interval = 1, index = 0)
    return time if @buses[index].nil?
    bus, offset = @buses[index]
    time = calculate_recursive(time + interval, interval, index) unless (time + offset) % bus == 0
    time = calculate_recursive(time, interval * bus, index + 1)
  end

  def load_from_file(filename)
    offset = 0
    File.readlines(filename, chomp: true)[1].split(',').each do |entry|
      @buses.append([entry.to_i, offset]) unless entry == 'x'
      offset += 1
    end
  end
end

require 'benchmark' 

buses = BusSchedule.new

buses.load_from_file('input')

reg_time = Benchmark.measure { 10000.times { buses.calculate } }
rec_time = Benchmark.measure { 10000.times { buses.calculate_recursive } }
puts "Reg: #{reg_time}Rec: #{rec_time}"

puts buses.calculate_recursive
puts buses.calculate