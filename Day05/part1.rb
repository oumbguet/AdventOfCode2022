require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class Stack
  def initialize()
    @stack = []
  end

  def push(value)
    @stack.push(value)
  end

  def pop()
    return @stack.pop()
  end

  def dump()
    puts "[#{@stack.join(', ')}]"
  end

  def reverse()
    @stack = @stack.reverse()
  end

  def top()
    return @stack[-1] ? @stack[-1] : " "
  end
end

class Ship
  def initialize(lines)
    stacksSchema = []
    @instructions = []

    # Retrieve schema
    isInstructionLine = false
    lines.each do |line|
      if line == ""
        isInstructionLine = true
        next
      end
      if isInstructionLine
        @instructions.push(line)
      else
        stacksSchema.push(line)
      end
    end

    # Init stacks
    @stacks = {}
    stacksSchema[-1].split(" ").each do |crate|
      @stacks[crate] = Stack.new()
    end

    # Fill stacks
    lines.each do |line|
      if !/(\s*\[[A-Z]\])/.match(line)
        break
      end
      @stacks.keys.each do |i|
        index = i.to_i - 1
        crate = line[1 + index * 4]
        if /[A-Z]/.match(crate)
          @stacks[i].push(crate)
        end
      end
    end

    # Reverse stacks
    @stacks.each do |key, stack|
     stack.reverse()
    end

  end

  def dump()
    @stacks.each do |key, stack|
      print key, " "
      stack.dump
    end
  end

  def moveCrate(a, b, n)
    1.upto(n) do |i|
      crate = @stacks[a].pop()
      @stacks[b].push(crate)
    end
  end

  def moveCrates()
    @instructions.each do |line|
      n, a, b = line.gsub("move ", "").gsub(" from ", "_").gsub(" to ", "_").split("_")
      moveCrate(a, b, n.to_i)
    end
  end

  def getResult()
    @stacks.each do |key, stack|
      print stack.top
    end
    puts
  end

end

s = Ship.new(lines)
s.moveCrates()
s.getResult() # TBVFVDZPN