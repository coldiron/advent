#! /usr/bin/env ruby

class TrainTicket
  attr_reader :rules, :this_ticket, :nearby_tickets

  def initialize(input)
    @rules = []
    @this_ticket = []
    @nearby_tickets = []
    @invalid_values = []
    parse(input)
    check_rules
  end

  def error_rate
    @invalid_values.sum
  end

  private

  def check_rules
    @nearby_tickets.each do |ticket|
      validate_nearby_ticket(ticket)
    end
  end

  def validate_nearby_ticket(ticket)
    ticket.each do |value|
      @invalid_values.append(value) unless valid_value(value)
    end
  end

  def parse(input)
    input = input.split("\n\n")
    parse_rules(input)
    parse_this_ticket(input)
    parse_nearby_tickets(input)
  end

  def parse_rules(input)
    input[0].lines.each do |line|
      add_rule(line)
    end
  end

  def parse_this_ticket(input)
    @this_ticket = input[1].lines[1].chomp.split(',').map(&:to_i)
  end

  def parse_nearby_tickets(input)
    input[2].lines.drop(1).each do |line|
      @nearby_tickets.append(line.chomp.split(',').map(&:to_i))
    end
  end

  def valid_value(value)
    valid = false
    @rules.each do |rule|
      break if valid

      valid = rule.validate(value)
    end
    valid
  end

  # "rule x: min1-max1 or min2-max2"
  def add_rule(line)
    name, ranges = line.split(':')
    @rules.append(TicketRule.new(name, ranges))
  end
end

# name: "Name", ranges: [[0, 1], [2, 3]]
class TicketRule
  attr_reader :name, :ranges

  def initialize(name, ranges)
    @name = ''
    @ranges = []
    from_strings(name, ranges)
  end

  def validate(value)
    value.between?(ranges[0][0], ranges[0][1]) || value.between?(ranges[1][0], ranges[1][1])
  end

  private

  def from_strings(name, ranges)
    @name = name
    split_ranges(ranges).each do |range|
      @ranges.append(parse_range(range))
    end
  end

  def split_ranges(range)
    range = range.split('or').map(&:strip)
    [range[0], range[1]]
  end

  def parse_range(range)
    range = range.split('-').map(&:strip)
    [range[0].to_i, range[1].to_i]
  end
end

ticket = TrainTicket.new(File.read('input'))

puts ticket.error_rate.to_s
