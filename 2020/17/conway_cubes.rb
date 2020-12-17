#! /usr/bin/env ruby

# Credit to vincentwoo on github - I've  based this on his implementation
class ConwayCubes
  def initialize(input)
    @state = {}
    @directions = []
    @input = input
    initialize_state
    @row_length = @state.first.first.length
    initialize_directions
  end

  def active_count
    @state.values.count(&:itself)
  end

  def play_a_round
    next_state = {}
    axes = @state.keys.transpose

    # Grow the space bounds each round
    axes.map! { |axis| ((axis.min - 1..axis.max + 1)).to_a }

    axes.first.product(*axes[1..-1]) do |position|
      next_state[position] = should_activate(position)
    end
    @state = next_state
  end

  def should_activate(position)
    n_count = neighbours_count(position)
    active_stay(position, n_count) || inactive_change(position, n_count)
  end

  def active_stay(position, n_count)
    @state[position] && [2, 3].include?(n_count)
  end

  def inactive_change(position, n_count)
    !@state[position] && n_count == 3
  end

  def initialize_state
    @input.each_with_index do |line, line_index|
      line.chars.each_with_index do |char, char_index|
        # Dimensionality is controlled by the number of entries in the 
        # key array
        @state[[line_index, char_index, 0, 0]] = (char == '#')
      end
    end
  end

  def neighbours_count(position)
    @directions.count { |direction| @state[direction.zip(position).map(&:sum)] }
  end

  def initialize_directions
    dirs = [0, -1, 1]
    @directions = dirs.product(*Array.new(@row_length - 1, dirs))
    @directions.shift
  end
end

input = DATA.readlines(chomp: true)
game = ConwayCubes.new(input)

6.times do
  game.play_a_round
end

puts game.active_count
__END__
#...#.#.
..#.#.##
..#..#..
.....###
...#.#.#
#.#.##..
#####...
.#.#.##.