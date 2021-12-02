input = File.read("#{__dir__}/input.txt").split("\n").map { |str| str.split(' ') }
x = 0
depth = 0

input.each do |cmd|
  direction, steps = cmd
  steps = steps.to_i

  case direction
  when 'forward'
    x += steps
  when 'up'
    depth -= steps
  when 'down'
    depth += steps
  end
end

p x * depth

x = 0
aim = 0
depth = 0

input.each do |cmd|
  direction, steps = cmd
  steps = steps.to_i

  case direction
  when 'forward'
    x += steps
    depth += aim * steps
  when 'up'
    aim -= steps
  when 'down'
    aim += steps
  end
end

p x * depth
