class BagContents
  attr_reader :contents

  def initialize(contents)
    @contents = contents
    parse_rule
  end

  def contains?(type)
    @contents.has_key?(type)
  end

  private

  def parse_rule
    contents_hash = {}
    contents_array = @contents.gsub('.', '').gsub('bags', '').gsub('bag', '').gsub('no', '0').split(',').each { |s| s.strip! }

    contents_hash = contents_array.to_h do |contents|
      [contents.gsub(/\d*/, '').strip, contents[/\d*/]]
    end
    @contents = contents_hash
  end
end

class BagRules
  def initialize
    @rules = {}
    @containers = []
  end

  def from_file(filename)
    get_rules(filename)
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

puts rules.can_contain_count('shiny gold')
