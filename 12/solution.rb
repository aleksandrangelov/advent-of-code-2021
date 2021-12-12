input = File.read("#{__dir__}/input.txt").split("\n")
$map = Hash.new { |hash, key| hash[key] = [] }

input.each do |path|
  a, b = path.split('-')
  #   p a, b
  $map[a] << b
end

$valid_paths = 0
def traverse_paths(point, path = Hash.new(0))
  small_caves_in_path = path.select { |k, _v| k.downcase == k && k != 'start' }
  return if small_caves_in_path.select { _2 >= 2 }.size > 1 || small_caves_in_path.any? { _2 > 2 }
  return if point == 'start' && path['start'] == 1

  path = path.clone
  path[point] += 1
  $valid_paths += 1 if point == 'end'
  return if point == 'end'

  adjacent_points = $map.select { _2.include?(point) }.map { _1 } + $map[point]
  adjacent_points.each { traverse_paths(_1, path) }
end

traverse_paths('start')
p $valid_paths
