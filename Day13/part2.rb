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

new_arr = []
lines.each do |line|
    if line != ""
        new_arr.push(eval(line))
    end
end
new_arr.push([[2]])
new_arr.push([[6]])

def isSorted(arr)
    0.upto(arr.length - 2) do |i|
        if !compareArrays(arr[i], arr[i + 1])
            return false
        end
    end
    return true
end

while !isSorted(new_arr)
    0.upto(new_arr.length - 2) do |i|
        if !compareArrays(new_arr[i], new_arr[i + 1])
            tmp = new_arr[i]
            new_arr[i] = new_arr[i + 1]
            new_arr[i + 1] = tmp
        end
    end
end

index_2 = new_arr.index([[[[2]]]])
index_6 = new_arr.index([[[[6]]]])

puts (index_2 + 1) * (index_6 + 1) # 20952
