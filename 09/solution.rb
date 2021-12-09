$input = File.read("#{__dir__}/input.txt").split("\n").map { _1.split('').map(&:to_i) }
risk_level_sum = 0
basin_points = []

# part 1
$input.each_with_index do |row, row_index|
  row.each_with_index do |col, col_index|
    next unless ($input[row_index - 1] ? col < $input[row_index - 1][col_index] : true) &&
                ($input[row_index + 1] ? col < $input[row_index + 1][col_index] : true) &&
                ($input[row_index][col_index - 1] ? col < $input[row_index][col_index - 1] : true) &&
                ($input[row_index][col_index + 1] ? col < $input[row_index][col_index + 1] : true)

    basin_points.push([row_index, col_index])
    risk_level_sum += (col + 1)
  end
end

# part 2
def count_basins(point)
  x, y = point

  return 0 if x.negative? || y.negative? || !$input[x] || !$input[x][y] || $input[x][y] == 9

  $input[x][y] = nil

  1 + count_basins([x + 1, y]) +
    count_basins([x - 1, y]) +
    count_basins([x, y + 1]) +
    count_basins([x, y - 1])
end

p basin_points.map { count_basins(_1) }.sort.last(3).reduce(&:*)
