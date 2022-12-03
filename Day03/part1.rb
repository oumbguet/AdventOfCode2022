file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

total = 0

def countScore(line)
    cmpSize = line.length / 2
    firstCmp = line[0...cmpSize]
    secondCmp = line[cmpSize..-1]
    
    firstCmp.split('').each do |c|
        secondCmp.split('').each do |m|
            if c == m
                return /[[:upper:]]/.match(c) ? c.ord - 38 : c.ord - 96
            end
        end
    end
    return 0
end

lines.each do |line|
    total += countScore(line)
end

puts total
