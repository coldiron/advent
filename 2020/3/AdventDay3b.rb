class AdventDay3b
  TREE = '#'.freeze

  attr_reader :trees_hit, :to_s

  def initialize(rise, run)
    @rise = rise
    @run = run
    @rows = get_rows
    @trees_hit = 0
    @to_s = ''

    toboggan!
  end

  private

  def toboggan!
    i = 0
    j = 0

    @rows.each do |row|
      if j % @rise == 0
        row_with_cursor = row.dup

        i -= row.length if i >= row.length - 1

        if is_tree?(row[i])
          @trees_hit += 1
          row_with_cursor[i] = 'X'
        else
          row_with_cursor[i] = 'O'
        end

        @to_s += "#{row} #{row_with_cursor}\n"

        i += @run
      end
      j += 1
    end
    @to_s += "Rise: #{@rise}, Run: #{@run}, Trees hit: #{@trees_hit}"
  end

  def is_tree?(j)
    j == TREE
  end

  def get_rows
    file = File.open('input')
    rows = file.read.split("\n")
    file.close
    rows
  end
end

route1 = AdventDay3b.new(-1, 1)
route2 = AdventDay3b.new(-1, 3)
route3 = AdventDay3b.new(-1, 5)
route4 = AdventDay3b.new(-1, 7)
route5 = AdventDay3b.new(-2, 1)

trees_product = (route1.trees_hit * route2.trees_hit * route3.trees_hit * route4.trees_hit * route5.trees_hit)

puts trees_product
