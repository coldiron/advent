# frozen_string_literal: true

class CustomsGroup
  attr_reader :answers

  def initialize(answers)
    @answers = answers
  end

  def unique_answers
    @answers.strip.gsub(/\n/, '').split('').uniq.length
  end
end

class CustomsGroups
  def initialize
    @groups = []
  end

  def from_file(filename)
    get_groups(filename)
  end

  def sum_unique_answers
    @groups.map(&:unique_answers).sum
  end

  private

  def get_groups(filename)
    file = File.open(filename)
    groups = file.read.split("\n\n")
    file.close
    groups.each do |group|
      @groups << CustomsGroup.new(group.strip)
    end
  end
end

groups = CustomsGroups.new

groups.from_file('input')

puts groups.sum_unique_answers
