$input = File.read("#{__dir__}/input.txt").split("\n").map { _1.split('').map(&:to_i) }
$flashes = 0
big_flash = false
step = 0

def explode(point)
  x, y = point
  return unless !x.negative? && !y.negative? && $input[x] && $input[x][y]

  return unless $input[x][y] != 'x'

  $input[x][y] += 1
  return unless $input[x][y] > 9

  $flashes += 1
  $input[x][y] = 'x'
  explode([x - 1, y - 1])
  explode([x - 1, y])
  explode([x - 1, y + 1])
  explode([x, y + 1])
  explode([x, y - 1])
  explode([x + 1, y + 1])
  explode([x + 1, y])
  explode([x + 1, y - 1])
end

until big_flash
  $input.each_with_index do |row, row_index|
    row.each_with_index do |number, col_index|
      if number == 9
        explode([row_index, col_index])
      elsif $input[row_index][col_index] != 'x'
        $input[row_index][col_index] += 1
      end
    end
  end

  $input.each_with_index do |row, row_index|
    row.each_with_index do |number, col_index|
      $input[row_index][col_index] = 0 if number == 'x'
    end
  end

  step += 1
  big_flash = true if $input.all? { _1.all?(0) }
end

p $flashes
p step
