class Ship
  attr_reader :heading, :position

  def initialize(orders = [])
    @orders = orders
    @heading = 90
    @position = { x: 0, y: 0 }
  end

  def follow_orders
    @orders.each do |order|
      send(order.scan(/\D/).join, order.scan(/\d*/).join.to_i)
    end
  end

  def load_orders(filename)
    @orders = File.readlines(filename, chomp: true)
  end

  def manhattan_distance
    @position[:x].abs + @position[:y].abs
  end

  private

  def N(distance)
    @position[:y] += distance
  end

  def S(distance)
    @position[:y] -= distance
  end

  def E(distance)
    @position[:x] += distance
  end

  def W(distance)
    @position[:x] -= distance
  end

  def L(degrees)
    degrees.times do |count|
      @heading = 360 if @heading == 0
      @heading -= 1
    end
  end

  def R(degrees)
    degrees.times do |count|
      @heading += 1
      @heading = 0 if @heading == 360
    end
  end

  def F(distance)
    case @heading
    when 0
      N(distance)
    when 90
      E(distance)
    when 180
      S(distance)
    when 270
      W(distance)
    end
  end
end

ship = Ship.new
ship.load_orders('input')
ship.follow_orders

puts "Heading: #{ship.heading} - Position: #{ship.position[:x]}, #{ship.position[:y]} - Manhattan Distance: #{ship.manhattan_distance}"

ship = Ship.new
ship.load_orders('input2')
ship.follow_orders

puts "Heading: #{ship.heading} - Position: #{ship.position[:x]}, #{ship.position[:y]} - Manhattan Distance: #{ship.manhattan_distance}"