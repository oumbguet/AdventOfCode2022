file = File.open("input", "r")
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

def find_score(scores, bonuses, play, goal)
    possible_scores = scores[play]
    goal = (goal.ord - 88) * 3

    return bonuses[possible_scores.key(goal)] + scores[play][possible_scores.key(goal)]
end

lines.each do |line|
    total += find_score(scores, bonuses, line[0], line[2])
end

puts total
