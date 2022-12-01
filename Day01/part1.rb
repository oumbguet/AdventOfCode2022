file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

arr = []

total = 0

lines.each do |line|
    if line == ""
        arr << total
        total = 0
    else
        total += line.to_i
    end
end

arr << total

puts arr.max()