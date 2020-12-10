# frozen_string_literal: true

require 'digest'

class AdventDay4b
  def initialize
    @input = 'yzbqklnj'
    @suffix = 0
  end

  def run
    @suffix += 1 until Digest::MD5.hexdigest(@input + @suffix.to_s)[0..5] == '000000'
    puts @suffix
    puts Digest::MD5.hexdigest(@input + @suffix.to_s)
  end
end

run = AdventDay4b.new
run.run
