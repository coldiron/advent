# frozen_string_literal: true

class AdventDay3a
  TREE = '#'

  attr_reader :trees_hit, :to_s

  def initialize(rise, run)
    @rise = rise # Rise component of slope
    @run = run # Run component of slope
    @rows = get_rows   # Rows of trees
    @trees_hit = 0     # Counter of trees hit while tobogganing along slope
    @to_s = ''

    toboggan!
  end

  private

  def toboggan!
    i = 0

    @rows.each do |row|
      rowWithCursor = row.dup

      i -= row.length if i >= row.length - 1

      if is_tree?(row[i])
        @trees_hit += 1
        rowWithCursor[i] = 'X'
      else
        rowWithCursor[i] = 'O'
      end

      @to_s += "#{row} #{rowWithCursor}\n"

      i += @run
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

route = AdventDay3a.new(-1, 3)
puts route
