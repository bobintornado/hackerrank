# this is quite hard
# maybe i will revisit this later
def run

  line1 = gets.strip.split(" ").map!{ |e| e.to_i }

  number_of_lines = line1[0]
  m = line1[1]
  k = line1[2]
  q = line1[3]

  maxtrix = Hash.new
  number_of_lines.times do |row|
    line = gets.strip.split(" ").map!{ |e| e.to_i }

    m.times do |col|
      maxtrix[[row,col]] = line[col]
    end
  end

  last_line = gets.strip.split(" ").map!{ |e| e.to_i }
  empty_slot = [last_line[0]-1,last_line[1]-1]
  caocao = [last_line[2]-1,last_line[3]-1]
  exit = [last_line[4]-1,last_line[5]-1]

  maxtrix[empty_slot] = "E"
  maxtrix[caocao] = "C"
  maxtrix[exit] = "D"

  knowledge_base = Hash.new

  printmap(number_of_lines, m, maxtrix)
end

def printmap (n, m, maxtrix)
  n.times do |row|
    m.times do |col|
      print maxtrix[[row,col]]
      print " "
    end
    puts " "
  end
end

run()

def travelMaxtrix(n, m, maxtrix, empty_slot)
  n.times do |row|
    m.times do |col|
      tryStep(row, col, maxtrix, empty_slot)
    end
  end
end

def tryStep(row, col, maxtrix, empty_slot)
  # can't move, simply return
  if maxtrix[[row,col]] == 0
    return -1
  # trying empty slot itself
  if [row,col] == empty_slot
    return -1 

  if neighbour?(row, col, maxtrix, empty_slot)
    move()
  else 
    swap()
  end

def neighbour?(row, col, maxtrix, empty_slot)
  if empty_slot[0] == row
    if empty_slot[1] == col - 1 ||  empty_slot[1] == col + 1
      return true
    end
  end
  if empty_slot[1] == col
    if empty_slot[1] == row - 1 ||  empty_slot[1] == row + 1
      return true
    end
  end
  return false;
end

def move (row, col, empty_slot)
  if empty_slot[0] == row
    if empty_slot[1] == col - 1
      move_left
    else 
      move_right
    end
  end
  if empty_slot[1] == col
    if empty_slot[1] == row - 1
      move_down
    else 
      move_up
    end
  end
end







 
