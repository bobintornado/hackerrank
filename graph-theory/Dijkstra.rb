class Node
  attr_accessor :number
  attr_accessor :distance
  attr_accessor :done 
  attr_accessor :children
end

cases = gets.to_i
cases.times do |time|
  n_n, n_e = gets.strip.split(" ").map! { |e| e.to_i }

  # create all nodes, and initialize distance to -1 (represents unreachable)
  nodes = Hash.new
  n_n.times do |n|
    node = Node.new
    node.done = false
    node.number = n+1
    node.distance = -1
    node.children = Hash.new
    nodes[n+1] = node
  end

  # construct the weighted undirected graph
  # since this is a undirected graph, we need to do double side construction
  n_e.times do |n|
    node1, node2, weight = gets.strip.split(" ").map! { |e| e.to_i }
    if nodes[node1].children[node2].nil?
      nodes[node1].children[node2] = weight
    else 
      # throw away unnecessary information, only keep shortest direct edge
      nodes[node1].children[node2] = weight if weight < nodes[node1].children[node2] 
    end

    if nodes[node2].children[node1].nil?
      nodes[node2].children[node1] = weight
    else 
      # same as above
      nodes[node2].children[node1] = weight if weight < nodes[node2].children[node1]
    end
  end

  # set up
  sp = gets.to_i 
  nodes[sp].distance = 0
  to_visited = Hash.new
  to_visited[sp] = 0

  # test if we have finish visiting all reachable nodes 
  # logic: for every single "undone" node, check if current distance is -1
  def finished? nodes
    nodes.each { |k,v| return false if !v.done && v.distance != -1 }
    return true 
  end

  # the loop goes as following:
  # pick the minimal (notice this minimal is current global optimal)
  # visit all its children (inserting too potential children)
  # mark itself as done
  # check if complete
  # if not completed then run loop again
  # if complete end the loop
  while !finished?(nodes)
    number,distance = to_visited.min_by { |k,v| v }.first
    parent_node = nodes[number]
    to_visited.delete(number)

    # visit all children of the parent node
    parent_node.children.each do |child_num, weight|  
      child_node = nodes[child_num]
      # skip if done
      next if child_node.done
      distance = parent_node.distance + weight
      if child_node.distance == -1
        child_node.distance = distance
      else 
        child_node.distance = distance if distance < child_node.distance
      end
      to_visited[child_node.number] = child_node.distance
    end
    # mark parent node as done
    parent_node.done = true
  end 

  # result printing
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