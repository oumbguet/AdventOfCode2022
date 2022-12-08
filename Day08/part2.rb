require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

def viewedTop(lines, i, j)
  viewed = 0
  currentTree = lines[i][j]

  (i - 1).downto(0) do |y|
    viewed += 1
    if (lines[y][j] >= currentTree)
      return viewed
    end
  end

  return viewed
end

def viewedBottom(lines, i, j)
  viewed = 0
  currentTree = lines[i][j]

  (i + 1).upto(lines.length - 1) do |y|
    viewed += 1
    if (lines[y][j] >= currentTree)
      return viewed
    end
  end

  return viewed
end

def viewedLeft(lines, i, j)
  viewed = 0
  currentTree = lines[i][j]

  (j - 1).downto(0) do |x|
    viewed += 1
    if (lines[i][x] >= currentTree)
      return viewed
    end
  end

  return viewed
end 

def viewedRight(lines, i, j)
  viewed = 0
  currentTree = lines[i][j]

  (j + 1).upto(lines[0].length - 1) do |x|
    viewed += 1
    if (lines[i][x] >= currentTree)
      return viewed
    end
  end

  return viewed
end

maxScore = 0

0.upto(lines.length - 1) do |i|
  0.upto(lines[0].length - 1) do |j|
    count = viewedTop(lines, i, j) * viewedRight(lines, i, j) * viewedBottom(lines, i, j) * viewedLeft(lines, i, j)
    maxScore = count > maxScore ? count : maxScore
  end
end

puts maxScore #519064
