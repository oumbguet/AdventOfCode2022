require 'set'

file = File.open("input", "r")
line = file.readlines.map(&:chomp)[0]

0.upto(line.length - 4) do |i|
  if line[i..i+3].split('').to_set.length == 4
    puts i + 4 # 1625
    return
  end
end
