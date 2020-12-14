class ElfMemoryGame
  def initialize(starting_numbers = {})
    @numbers_spoken = starting_numbers
  end

  def play_a_round
    if last_number_is_new
      say(0)
    else
      say(turns_since_last_number_spoken)
    end
  end

  def last_number_spoken
    @numbers_spoken.last
  end

  private

  def say(number)
    @numbers_spoken.append(number)
  end

  def times_last_number_was_spoken
    all_but_last_number_spoken.count(last_number_spoken)
  end

  def last_number_is_new
    times_last_number_was_spoken == 0
  end

  def all_but_last_number_spoken
    @numbers_spoken[0..-2]
  end

  def turns_since_last_number_spoken
    @numbers_spoken.length - (all_but_last_number_spoken.rindex(last_number_spoken)) - 1
  end
end

starting_numbers = [16, 1, 0, 18, 12, 14, 19]

game = ElfMemoryGame.new(starting_numbers)

(2020 - starting_numbers.length).times do
  game.play_a_round
end

puts game.last_number_spoken