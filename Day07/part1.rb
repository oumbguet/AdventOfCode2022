require 'set'

file = File.open("input", "r")
lines = file.readlines.map(&:chomp)

class File

  def initialize(line)
    a, b = line.split(" ")
    @size = a.to_i
    @name = b
  end

  attr_reader :size, :name
  attr_writer :size, :name

end

class Node

  def initialize(name)
    @prev = nil
    @next = []
    @files = []
    @name = name
    @size = 0
  end

  def dump(n = 0)
    print "." * n * 2, "#{@name} (dir: #{@size})"
    puts
    @next.each do |nex|
      nex.dump(n + 1)
    end
    @files.each do |file|
      print "." * (n + 1) * 2, "#{file.name} (file: #{file.size})"
      puts
    end
    print ""
  end

  def initDirSize()
    files_size = @files.length > 0 ? @files.map {|file| file.size}.sum() : 0
    dirs_size = @next.length > 0 ? @next.map {|dir| dir.initDirSize()}.sum() : 0
    total_size = files_size + dirs_size
    @size = total_size
    return total_size
  end

  def countDirSize(max=100000)
    total_size = @next.map {|dir| dir.countDirSize(max)}.sum()
    total_size += @size <= max ? @size : 0

    return total_size
  end

  attr_reader :prev, :next, :files, :name
  attr_writer :prev, :next, :files, :name

end

class LinkedList

  def initialize(root)
    @current = Node.new(root)
    @head = @current
  end

  def addNode(name)
    newNode = Node.new(name)
    @current.next.push(newNode)
    newNode.prev = @current
  end

  def addFile(file)
    @current.files.push(File.new(file))
  end

  def moveNode(name)
    nextNode = @current.next.find { |n| n.name == name }
    if nextNode
      @current = nextNode
    end
  end

  def moveBack()
    @current = @current.prev
  end

  def moveRoot()
    @current = @head
  end

  attr_reader :current, :head
  attr_writer :current, :head

end

def handleLsLine(l, line)
  if /(dir).*/.match(line)
    l.addNode(line.gsub("dir ", ""))
  elsif /[0-9].*/.match(line)
    l.addFile(line)
  end
end

def handleCdLine(l, line)
  cmd = line.gsub("$ cd ", "")
  if (cmd == "..")
    l.moveBack()
  elsif (cmd == "/")
    l.moveRoot()
  else
    l.moveNode(cmd)
  end
end

l = LinkedList.new(lines[0].gsub("$ cd ", ""))

lines[1..-1].each do |line|
  if /(\$ cd ).*/.match(line)
    handleCdLine(l, line)
  elsif /(\$ ls)/.match(line)
    
  else
    handleLsLine(l, line)
  end
end

l.head.initDirSize()
puts l.head.dump()
puts l.head.countDirSize() # 1783610
