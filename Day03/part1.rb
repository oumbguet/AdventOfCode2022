require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

def countScore(line)
    line = line.split('')
    cmpSize = line.length / 2
    firstCmp = line[0...cmpSize].to_set
    secondCmp = line[cmpSize..-1].to_set
    c = (firstCmp & secondCmp).to_a[0]

    return /[[:upper:]]/.match(c) ? c.ord - 38 : c.ord - 96
end

puts lines.map{|line| countScore(line)}.sum() #7568
