class ElfMemoryGame
  attr_reader :numbers, :last_number

  def initialize(start)
    @numbers = start
    @turns = {}
    @numbers.each_with_index do |number, index|
      @turns[number] = [index + 1]
    end
    @last = start.last
  end

  def play_a_round
    going_to_say = 0

    if @turns.dig(@last)
      going_to_say = turn_difference
    end

    @numbers.append(going_to_say)

    if @turns.has_key?(numbers.last)
      @turns[going_to_say] = [@turns[going_to_say].last, numbers.length]
    else
      @turns[going_to_say] = [numbers.length]
    end
    @last = going_to_say
  end

  def turn_difference
    if @turns[@last].length > 1
      @turns[@last].last - @turns[@last][-2]
    else
      @numbers.length - @turns[@last].last
    end
  end

  def last_number
    @last
  end
end

starting_numbers = [2,3,1]
starting_numbers = [0, 3, 6]
starting_numbers = [16, 1, 0, 18, 12, 14, 19]

game = ElfMemoryGame.new(starting_numbers)

(30000000 - starting_numbers.length).times do
  game.play_a_round
end

puts game.last_number