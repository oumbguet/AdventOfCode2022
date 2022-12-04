require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

def isSubset(line)
    set1, set2 = line.split(',').map do |pair|
        a, b = pair.split('-')
        (a..b).to_set
    end

    union = set1 & set2
    return union == set1 || union == set2
end

puts lines.map { |line|
    isSubset(line) ? 1 : 0
}.sum() #580
