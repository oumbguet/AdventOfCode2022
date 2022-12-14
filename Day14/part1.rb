file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class Map
  def initialize(lines)
    min_x, max_x, min_y, max_y = getSize(lines)
    width = max_x - min_x + 1
    height = max_y + 1
    @map = Array.new(height){Array.new(width, ".")}
    @offset = min_x
    @map[0][500 - @offset] = "+"

    lines.each do |line|
      drawLine(line)
    end
  end

  def getSize(lines)
    tmp_min_x, tmp_min_y = 9999, 9999
    tmp_max_x, tmp_max_y = 0, 0

    lines.each do |line|
      line.split(" -> ").each do |tuple|
        x, y = tuple.split(",").map(&:to_i)
        tmp_min_x = x < tmp_min_x ? x : tmp_min_x
        tmp_min_y = y < tmp_min_y ? y : tmp_min_y
        tmp_max_x = x > tmp_max_x ? x : tmp_max_x
        tmp_max_y = y > tmp_max_y ? y : tmp_max_y
      end
    end
    return [tmp_min_x, tmp_max_x, tmp_min_y, tmp_max_y]
  end

  def drawLine(line)
    lines = line.split(" -> ")
    0.upto(lines.length - 2) do |index|
      x1, y1 = lines[index].split(",").map(&:to_i)
      x1 -= @offset
      x2, y2 = lines[index + 1].split(",").map(&:to_i)
      x2 -= @offset

      [x1, x2].min.upto([x1, x2].max) do |i|
        [y1, y2].min.upto([y1, y2].max) do |j|
          @map[j][i] = "#"
        end
      end
    end
  end

  def addSand()
    x, y = 500 - @offset, 1
    return moveSand(x, y)
  end

  def moveSand(x, y)
    # If sand falls out of the map
    if (y + 1 >= @map.length || x < 0 || x >= @map[0].length)
      return false
    end

    @map[y][x] = "o"

    # If sand should stay in place
    if ((x - 1 > 0 && (@map[y + 1][x - 1] == "o" || @map[y + 1][x - 1] == "#")) && ((@map[y + 1][x] == "o" || @map[y + 1][x] == "#")) && (x + 1 < @map[0].length && (@map[y + 1][x + 1] == "o" || @map[y + 1][x + 1] == "#")))
      return true
    end

    # If sand can move
    if (@map[y + 1][x] == ".")
      @map[y][x] = "."
      return moveSand(x, y + 1)
    elsif (x - 1 < 0 || @map[y + 1][x - 1] == ".")
      @map[y][x] = "."
      return moveSand(x - 1, y + 1)
    elsif (x + 1 >= @map[0].length || @map[y + 1][x + 1] == ".")
      @map[y][x] = "."
      return moveSand(x + 1, y + 1)\
    end
  end

  def dump()
    puts ""
    @map.each do |line|
      puts line.join("")
    end
    puts ""
  end

end

map = Map.new(lines)
count = 0

while map.addSand != false
  count += 1
end

map.dump()

puts count # 672
