require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class CPU

  def initialize
    @cycle = 0
    @x = 1
    @watched = [20, 60, 100, 140, 180, 220]
    @results = {}
  end

  def operation(line)
    if /(noop)/.match(line)
      @cycle += 1
      if (@watched.include?(@cycle) && !@results[@cycle])
        @results[@cycle] = @x
      end
    elsif /(addx).*/.match(line)
      addx(1, line.split(" ")[1].to_i) #0
    end
  end

  def addx(tick, value)
    if (@watched.include?(@cycle) && !@results[@cycle])
      @results[@cycle] = @x
    end
    
    if tick == 1
      @cycle += 1 #1
      addx(tick + 1, value)
    else
      @cycle += 1 #2
      if (@watched.include?(@cycle) && !@results[@cycle])
        @results[@cycle] = @x
      end
      @x += value
    end
  end

  attr_reader :x, :cycle, :results

end

cpu = CPU.new()

lines.each do |line|
  cpu.operation(line)
end

sum = 0

cpu.results.each do |key, value|
  sum += key * value
end

puts sum #13680
