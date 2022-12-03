file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

total = 0

def findMatchingChar(a, b, c)
    
    a.split('').each do |i|
        b.split('').each do |j|
            c.split('').each do |k|
                if i == j && j == k
                    return i
                end
            end
        end
    end
    return nil
end

(0...lines.length).step(3) do |i|
    badge = findMatchingChar(lines[i], lines[i + 1], lines[i + 2])
    total += /[[:upper:]]/.match(badge) ? badge.ord - 38 : badge.ord - 96
end

puts total #2780
