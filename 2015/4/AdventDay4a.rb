# frozen_string_literal: true

require 'digest'

class AdventDay4a
  def initialize
    @input = 'yzbqklnj'
    @suffix = 0
  end

  def run
    @suffix += 1 until Digest::MD5.hexdigest(@input + @suffix.to_s)[0..4] == '00000'
    puts @suffix
  end
end

run = AdventDay4a.new
run.run
