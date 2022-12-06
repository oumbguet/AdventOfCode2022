require 'set'

file = File.open("input", "r")
line = file.readlines.map(&:chomp)[0]

packet_length = 14

0.upto(line.length - packet_length) do |i|
  if line[i...i+packet_length].split('').to_set.length == packet_length
    puts i + packet_length # 2250
    return
  end
end
