require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

def blockedTop(lines, i, j)
  blocked = false
  currentTree = lines[i][j]

  (i - 1).downto(0) do |y|
    if (lines[y][j] >= currentTree)
      blocked = true
    end
  end

  return blocked
end

def blockedBottom(lines, i, j)
  blocked = false
  currentTree = lines[i][j]

  (i + 1).upto(lines.length - 1) do |y|
    if (lines[y][j] >= currentTree)
      blocked = true
    end
  end

  return blocked
end

def blockedLeft(lines, i, j)
  blocked = false
  currentTree = lines[i][j]

  (j - 1).downto(0) do |x|
    if (lines[i][x] >= currentTree)
      blocked = true
    end
  end

  return blocked
end 

def blockedRight(lines, i, j)
  blocked = false
  currentTree = lines[i][j]

  (j + 1).upto(lines[0].length - 1) do |x|
    if (lines[i][x] >= currentTree)
      blocked = true
    end
  end

  return blocked
end

count = 0

0.upto(lines.length - 1) do |i|
  0.upto(lines[0].length - 1) do |j|
    count += !blockedTop(lines, i, j) || !blockedRight(lines, i, j) || !blockedBottom(lines, i, j) || !blockedLeft(lines, i, j) ? 1 : 0
  end
end

puts count #1546
