require "set"
require "colorize"

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class Node

  def initialize(value, i, j)
    @value = value
    @i = i
    @j = j
    @visited = false
    @parent = nil
    @correctWay = false
    @neighbours = []
  end

  def setCorrectWay()
    @correctWay = true
    count = 0
    if @parent != nil
      count += 1 + @parent.setCorrectWay()
    end
    return count

  end

  def setNeighbours(map, i, j)
    if (i - 1) >= 0 && (@value == "S" || map[i - 1][j].value == "E" || map[i - 1][j].value.ord <= @value.ord + 1)
      @neighbours.push map[i - 1][j]
    end
    if (i + 1) < map.length && (@value == "S" || map[i + 1][j].value == "E" || map[i + 1][j].value.ord <= @value.ord + 1)
      @neighbours.push map[i + 1][j]
    end
    if (j - 1) >= 0 && (@value == "S" || map[i][j - 1].value == "E" || map[i][j - 1].value.ord <= @value.ord + 1)
      @neighbours.push map[i][j - 1]
    end
    if (j + 1) < map[0].length && (@value == "S" || map[i][j + 1].value == "E" || map[i][j + 1].value.ord <= @value.ord + 1)
      @neighbours.push map[i][j + 1]
    end
  end

  attr_reader :value, :visited, :i, :j, :parent, :correctWay, :neighbours
  attr_writer :visited, :parent, :correctWay

end

class Map

  def initialize(lines, x, y)
    @map = lines.map.with_index { |line, i| line.split("").map.with_index { |char, j| Node.new(char, i, j) } }
    @map.each_with_index { |line, i| line.each_with_index { |node, j| node.setNeighbours(@map, i, j) } }
    @queue = []
    @count = 0

    (0...@map.length).each do |i|
      (0...@map[0].length).each do |j|
        if @map[i][j].value == "S"
          @map[i][j].value == "a"
          @map[x][y].value == "S"
          @queue.push(@map[x][y])
        end
      end
    end
  end

  def bfs()
    while @queue.length > 0 && @count < 100000
      current = @queue.shift

      if current.visited
        next
      end
      current.visited = true
      @count += 1

      if current.value == "E"
        result = current.setCorrectWay()
        return result
      end

      current.neighbours.each do |neighbour|
        if !neighbour.visited
          neighbour.parent = current
          @queue.push(neighbour)
        end
      end
    end
  end

  def dump()
    @map.each do |line|
      puts line.map{ |node| node.visited ? node.correctWay ? node.value.yellow : node.value.red : node.value.white }.join("")
    end
  end

end

tmp = 999

0.upto(lines.length - 1) do |i|
    map = Map.new(lines, i, 0)
    s = map.bfs()
    tmp = s < tmp ? s : tmp
end

puts "Minimum number of steps: #{tmp}" # 451
