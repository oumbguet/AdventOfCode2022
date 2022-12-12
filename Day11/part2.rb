require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class Monkey

  def initialize(lines, index)
    @id = index
    @items = lines[1].split(": ")[1].split(", ").map(&:to_i)
    @operator = lines[2].split(" ")[-2]
    @operationNb = lines[2].split(" ")[-1]
    @divisor = lines[3].split(" ")[-1].to_i
    @trueMonkey = lines[4].split(" ")[-1].to_i
    @falseMonkey = lines[5].split(" ")[-1].to_i
    @count = 0
  end

  def inspectObjects(monkeys)
    @items.each do |item|
      @count += 1
      worryLevel = item.method(@operator).(@operationNb == "old" ? item : @operationNb.to_i)
      # worryLevel = (worryLevel / 3).floor
      worryLevel %= monkeys.map { |monkey| monkey.divisor }.inject(:*)
      if worryLevel % @divisor == 0
        monkeys[@trueMonkey].throwItem(worryLevel)
      else
        monkeys[@falseMonkey].throwItem(worryLevel)
      end
    end

    @items = []
  end

  def throwItem(number)
     @items.push(number)
  end

  def dump()
    puts " "
    puts "Monkey #{@id}"
    puts "@items: #{@items}"
    puts "@operator: #{@operator}"
    puts "@operationNb: #{@operationNb}"
    puts "@divisor: #{@divisor}"
    puts "@trueMonkey: #{@trueMonkey}"
    puts "@falseMonkey: #{@falseMonkey}"
    puts "@count: #{@count}"
    puts " "
  end

  attr_reader :count, :divisor

end

monkeys = []

0.upto(7) do |i|
  monkeys.push(Monkey.new(lines[i * 7..i * 7 + 5], i))
end

0.upto(9999) do
  monkeys.each do |monkey|
    monkey.inspectObjects(monkeys)
  end
end

monkeys.each do |monkey|
  puts monkey.count
end
puts monkeys.map { |monkey| monkey.count }.sort()[-2..].inject(:*) # 54036