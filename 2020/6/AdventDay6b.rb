class CustomsGroup
  attr_reader :answers

  def initialize(answers)
    @members = answers.split("\n")
  end

  def shared_answers_count
    answered_yes = {}

    @members.each do |member|
      member.split('').each do |answer|
        if answered_yes.key?(answer)
          answered_yes[answer] += 1
        else
          answered_yes[answer] = 1
        end
      end
    end

    answered_yes.keep_if { |_, value| value == @members.length }

    answered_yes.length
  end
end

class CustomsGroups
  def initialize
    @groups = []
  end

  def from_file(filename)
    get_groups(filename)
  end

  def sum_shared_answers
    @groups.map do |group|
      group.shared_answers_count
    end.sum
  end

  private

  def get_groups(filename)
    file = File.open(filename)
    groups = file.read.split("\n\n")
    file.close
    groups.each do |group|
      @groups << CustomsGroup.new(group)
    end
  end
end

groups = CustomsGroups.new

groups.from_file('input')

puts groups.sum_shared_answers
