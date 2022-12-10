require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class CPU

  def initialize
    @cycle = 0
    @x = 1
  end

  def operation(line)
    if @cycle > 0 && @cycle % 40 == 0
        puts ""
    end
    if /(noop)/.match(line)
      drawPixel()
      @cycle += 1
    elsif /(addx).*/.match(line)
      addx(1, line.split(" ")[1].to_i) #0
    end
  end

  def addx(tick, value)
    if tick > 1 && @cycle % 40 == 0
        puts ""
    end
    drawPixel()
    if tick == 1
      @cycle += 1
      addx(tick + 1, value)
    else
      @cycle += 1
      @x += value
    end
  end

  def drawPixel()
    if @cycle == @x + 40 * (@cycle / 40).floor - 1 || @cycle == @x + 40 * (@cycle / 40).floor || @cycle == @x + 40 * (@cycle / 40).floor + 1
        print "#"
    else
        print "."
    end
  end

  attr_reader :x, :cycle, :results

end

cpu = CPU.new()

lines.each do |line|
  cpu.operation(line)
end

puts ""
# PZGPKPEB