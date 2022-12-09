require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class Head

  def initialize(x, y)
    @x = x
    @y = y
    @tail = Tail.new(x, y, 8)
  end

  def move(direction, n)
    n.times do
      case direction
      when "U"
        @y -= 1
      when "R"
        @x += 1
      when "D"
        @y += 1
      when "L"
        @x -= 1
      else
        pass
      end

      @tail.move(@x, @y)
    end
  end

  def dump()
    puts "Head at x: #{@x}, y: #{@y}"
    puts "Tail at x: #{@tail.x}, y: #{@tail.y}"
  end

  def getTail()
    tail = @tail.getTail()
    if tail != nil
      return tail
    end
    return nil
  end

  attr_reader :x, :y, :tail
  attr_writer :x, :y, :tail

end

class Tail

  def initialize(x, y, tailNumber)
    @id = 9 - tailNumber
    @x = x
    @y = y
    @visited = ["#{x} #{y}"].to_set
    @tail = tailNumber > 0 ? Tail.new(x, y, tailNumber - 1) : nil
  end

  def move(x, y)
    dist_x = x - @x
    dist_y = y - @y
    
    shouldMove = {
      "U" => dist_y < -1 || (dist_y < 0 && dist_x.abs() > 1),
      "R" => dist_x > 1 || (dist_x > 0 && dist_y.abs() > 1),
      "D" => dist_y > 1 || (dist_y > 0 && dist_x.abs() > 1),
      "L" => dist_x < -1 || (dist_x < 0 && dist_y.abs() > 1)
    }

    @x += shouldMove["R"] ? 1 : shouldMove["L"] ? -1 : 0
    @y += shouldMove["D"] ? 1 : shouldMove["U"] ? -1 : 0
    if !@visited.include?("#{@x} #{@y}")
      @visited.add("#{@x} #{@y}")
    end

    if @tail != nil
      @tail.move(@x, @y)
    end
  end

  def getTail()
    if @tail == nil
      return nil
    end
    tail = @tail.getTail()
    if (tail == nil)
      return @tail
    else
      return tail
    end
  end

  attr_reader :x, :y, :visited, :id
  attr_writer :x, :y, :visited, :id

end

head = Head.new(0, 0)

lines.each do |line|
  a, b = line.split(" ")
  head.move(a, b.to_i)
end
head.dump()
puts head.getTail().visited.length
