require 'set'

class Node
  attr_accessor :connections
  attr_accessor :distance
end

cases = gets.to_i
cases.times do |time|
  n_n, n_e = gets.strip.split(" ").map! { |e| e.to_i }

  nodes = Hash.new

  n_e.times do |n|
    num_1, num_2 = gets.strip.split(" ").map! { |e| e.to_i }

    if nodes[num_1].nil?
      node = Node.new
      node.connections = Set.new [num_2]
      node.distance = -1
      nodes[num_1] = node
    else 
      nodes[num_1].connections = nodes[num_1].connections.add num_2
    end

    if nodes[num_2].nil?
      node = Node.new
      node.connections = Set.new [num_1]
      node.distance = -1
      nodes[num_2] = node
    else 
      nodes[num_2].connections = nodes[num_2].connections.add num_1
    end
    
  end

  str_point = gets.to_i

  # handle edge case where node is not connected to anyone
  if nodes[str_point].nil?
    node = Node.new
    node.connections = Set.new
    node.distance = 0
    nodes[str_point] = node
  else 
    nodes[str_point].distance = 0
  end

  queue = [str_point]

  while !queue.empty?
    number = queue.shift
    connections = nodes[number].connections

    connections.each do |con|
      if nodes[con].distance == -1
        nodes[con].distance = nodes[number].distance + 6
        queue << con
      end
    end
  end

  result = ""
  n_n.times do |i|
    if nodes[i+1].nil?
      result += "-1 "
    else
      if nodes[i+1].distance != 0
        result = result + nodes[i+1].distance.to_s + " "
      end
    end
  end

  puts result
end