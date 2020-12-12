class Ship
  def initialize(orders = [])
    @orders = orders
    @position = { x: 0, y: 0 }
    @waypoint = { x: 10, y: 1 }
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
    @waypoint[:y] += distance
  end

  def S(distance)
    @waypoint[:y] -= distance
  end

  def E(distance)
    @waypoint[:x] += distance
  end

  def W(distance)
    @waypoint[:x] -= distance
  end

  def L(degrees)
    (degrees / 90).times do
      @waypoint = { x: (0 - @waypoint[:y]), y: @waypoint[:x]}
    end
  end

  def R(degrees)
    (degrees / 90).times do
      @waypoint = { x: @waypoint[:y], y: (0 - @waypoint[:x])}
    end
  end

  def F(distance)
    @position[:x] += (@waypoint[:x] * distance)
    @position[:y] += (@waypoint[:y] * distance)
  end
end

ship = Ship.new
ship.load_orders('input')
ship.follow_orders

puts "Manhattan Distance: #{ship.manhattan_distance}"
