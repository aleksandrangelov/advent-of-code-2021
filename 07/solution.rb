input = File.read("#{__dir__}/input.txt").gsub(/^$\n/, '').split(',').map(&:to_i)
positions = Hash[input.each_with_index.map { [_2, 0] }]
fuel_cost_map = {}

positions.each do |key, _val|
  input.each do |fuel|
    diff = (fuel - key).abs
    fuel_cost = diff.zero? ? 0 : (fuel_cost_map[diff] || (1..diff).reduce(&:+))
    positions[key] += fuel_cost
    fuel_cost_map[diff] = fuel_cost
  end
end

p positions.min_by { _2 }
