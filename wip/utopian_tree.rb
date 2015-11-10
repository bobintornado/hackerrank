cases = gets.to_i


cases.times do |n|
  line = gets.strip.split(" ").map! { |e| e.to_i }
  row = line[0]
  col = line[1]
  
  string = ""
  row.times do |i|
    string = string + gets
  end

  line = gets.strip.split(" ").map! { |e| e.to_i }
  p_row = line[0]
  p_col = line[1]

  b = col - p_col
  b_reg = ".{#{b}}"
  reg = ""
  p_row.times do |i|
    reg = reg + gets + b_reg
  end

  reg = reg[0..-b_reg.length]
  
  puts "regex is"
end







