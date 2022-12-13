require "set"

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

def compareArrays(arr1, arr2)
  0.upto(arr1.length - 1) do |i|
    # puts "Compare #{arr1[i]} #{arr2[i]}"
    if arr1[i].kind_of?(Integer) && arr2[i].kind_of?(Integer)
      if arr1[i] > arr2[i]
        return false
      elsif arr1[i] < arr2[i]
        return true
      end
    elsif arr1[i].kind_of?(Array) && arr2[i].kind_of?(Array)
      res = compareArrays(arr1[i], arr2[i])
      if res
        return true
      elsif res == false
        return false
      end
    elsif arr1[i].kind_of?(Array) && arr2[i].kind_of?(Integer)
      arr2[i] = [arr2[i]]
      res = compareArrays(arr1[i], arr2[i])
      if res
        return true
      elsif res == false
        return false
      end
    elsif arr1[i].kind_of?(Integer) && arr2[i].kind_of?(Array)
      arr1[i] = [arr1[i]]
      res = compareArrays(arr1[i], arr2[i])
      if res
        return true
      elsif res == false
        return false
      end
    end
  end

  if (arr2.length < arr1.length)
    return false
  elsif (arr2.length > arr1.length)
    return true
  end

  return nil
end

result = 0

(0..lines.length - 2).step(3).each do |i|
  line1 = eval(lines[i])
  line2 = eval(lines[i + 1])

  res = compareArrays(line1, line2)
  if res
    result += 1 + i / 3
  end
end

puts result # 5503
