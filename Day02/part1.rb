file = File.open("test_input", "r")
lines = file.readlines.map(&:chomp)

total = 0

scores = {
    'A' => {
        'X' => 3,
        'Y' => 6,
        'Z' => 0
    },
    'B' => {
        'X' => 0,
        'Y' => 3,
        'Z' => 6
    },
    'C' => {
        'X' => 6,
        'Y' => 0,
        'Z' => 3
    }
}

bonuses = {
    'X' => 1,
    'Y' => 2,
    'Z' => 3
}

lines.each do |line|
    total += scores[line[0]][line[2]] + bonuses[line[2]]
end

puts total
