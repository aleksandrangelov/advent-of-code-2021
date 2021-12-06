input = File.read("#{__dir__}/input.txt").gsub(/^$\n/, '').split("\n")
instructions = input.map { |instruction| instruction.split(' -> ') }

map = Hash.new(0)

instructions.each do |instruction|
  start_point, end_point = instruction
  x1, y1 = start_point.split(',').map(&:to_i)
  x2, y2 = end_point.split(',').map(&:to_i)

  if x1 != x2 && y1 != y2
    x_points = x1.step(by: x1 < x2 ? 1 : -1, to: x2)
    y_points = y1.step(by: y1 < y2 ? 1 : -1, to: y2)

    x_points.zip(y_points).each do |point|
      x, y = point
      map["#{x}:#{y}"] += 1
    end

    next

  end

  if x1 != x2
    min, max = [x1, x2].sort

    (min..max).each do |x|
      map["#{x}:#{y1}"] += 1
    end
  end

  next unless y1 != y2

  min, max = [y1, y2].sort
  (min..max).each do |y|
    map["#{x1}:#{y}"] += 1
  end
end

# p map
p map.count { _2 >= 2 }
