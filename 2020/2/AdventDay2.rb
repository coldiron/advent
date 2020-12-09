class AdventDay2
  def initialize
    puts count
  end

  private

  def count
    count = 0
    count2 = 0
    rows = get_rows
    rows.each do |row|
      count += 1 if is_valid?(row)
    end
    count
  end

  def is_valid?(row)
    min = row.match(/\d*-\d*/)[0].split('-')[0].to_i
    max = row.match(/\d*-\d*/)[0].split('-')[1].to_i
    character = row.match(/[a-zA-Z]/)[0]
    password = row.split(': ')[1].to_s

    char_count = password.count(character)

    char_count >= min && max >= char_count
  end

  def getRows
    file = File.open('input')
    rows = file.read.split("\n")
    file.close
    rows
  end
end

adv = AdventDay2.new
