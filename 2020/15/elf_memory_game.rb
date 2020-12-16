class ElfMemoryGame
  attr_reader :last_number

  def initialize(start)
    @last_two_turns_for = {}

    start.each_with_index do |number, index|
      @last_two_turns_for[number] = [index + 1]
    end

    @last_number = start.last
    @turn = start.length
  end

  def play_to_round(count)
    (count - @turn).times do
      play_a_round
    end
  end

  private

  def play_a_round
    @turn += 1
    this_number = 0
    this_number = turn_difference unless last_number_is_new?
    update_turns(this_number)
    @last_number = this_number
  end

  def last_number_is_new?
    @last_two_turns_for[@last_number].length == 1
  end

  def update_turns(number)
    @last_two_turns_for[number] = if @last_two_turns_for.has_key?(number)
                                    [@last_two_turns_for[number].last, @turn]
                                  else
                                    [@turn]
                                  end
  end

  def turn_difference
    @last_two_turns_for[@last_number].last - @last_two_turns_for[@last_number][-2]
  end
end

starting_numbers = [16, 1, 0, 18, 12, 14, 19]

game = ElfMemoryGame.new(starting_numbers)

game.play_to_round(2020)
puts game.last_number

game.play_to_round(30_000_000)
puts game.last_number
