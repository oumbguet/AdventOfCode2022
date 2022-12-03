require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

total = 0

def findMatchingChar(a, b, c)
    return (a.split('').to_set & b.split('').to_set & c.split('').to_set).to_a[0]
end

(0...lines.length).step(3) do |i|
    badge = findMatchingChar(*lines[i..i + 2])
    total += /[[:upper:]]/.match(badge) ? badge.ord - 38 : badge.ord - 96
end

puts total #2780
