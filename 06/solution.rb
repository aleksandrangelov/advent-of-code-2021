input = File.read("#{__dir__}/input.txt").gsub(/^$\n/, '').split(',').map(&:to_i)
map = input.group_by(&:itself).transform_values!(&:size)

(0...256).each do |_day|
  new_map = Hash[(0..8).map { |num| [num, 0] }]
  map.each do |key, v|
    if key.zero?
      new_map[6] += map[key]
      new_map[8] = map[key]
    else
      new_map[key - 1] += map[key]
    end
  end

  map = new_map
end

p map.values.reduce(&:+)
