# frozen_string_literal: true

class BagContents
  attr_reader :contents

  def initialize(contents)
    @contents = contents
    parse_rule
  end

  def contains?(type)
    @contents.key?(type)
  end

  private

  def parse_rule
    @contents_array = @contents.gsub('.', '').gsub('bags', '').gsub('bag', '').gsub('no', '0').split(',').each(&:strip!)

    @contents = @contents_array.to_h do |contents|
      [contents.gsub(/\d*/, '').strip, contents[/\d*/]]
    end
  end
end

class BagRules
  attr_reader :required

  def initialize
    @required = 0
    @rules = {}
    @containers = []
    @contents = {}
  end

  def from_file(filename)
    get_rules(filename)
  end

  def required_contents(type)
    @rules[type].contents.each do |bag_type, bag_count|
      next if bag_type == 'other'

      bag_count = bag_count.to_i
      @required += bag_count
      bag_count.times do
        required_contents(bag_type)
      end
    end
  end

  def can_contain_count(type)
    check_container(type)

    @containers.each do |container|
      check_container(container)
    end

    @containers.length
  end

  private

  def check_container(container)
    @rules.each do |k, v|
      next unless v.contains?(container)

      @containers.append(k) unless @containers.include? k
    end
  end

  def get_rules(filename)
    file = File.open(filename)
    rules = file.read.split("\n")
    file.close
    rules.each do |rule|
      rule = rule.split('contain')
      @rules[rule[0].gsub('bags', '').gsub('bag', '').strip] = BagContents.new(rule[1])
    end
  end
end

rules = BagRules.new

rules.from_file('input')

rules.required_contents('shiny gold')

puts rules.required
