input = File.read("#{__dir__}/input.txt").split(/\n\n/)
dots, folds = input
dots = dots.split("\n")
folds = folds.split("\n")
max_y = dots.map { _1.split(',')[1].to_i }.max
max_x = dots.map { _1.split(',')[0].to_i }.max

map = Array.new(max_y + 1) { Array.new(max_x + 1, '.') }
dots.each do |dot|
  x, y = dot.split(',').map(&:to_i)

  map[y][x] = '#'
end

dots = 0
until folds.empty?
  fold = folds.shift.split(' ').last
  fold_direction, line = fold.split('=')

  if fold_direction == 'y'
    upper_half = map.slice(0...line.to_i)
    lower_half = map.slice(line.to_i + 1, map.length).reverse

    map = upper_half.each_with_index.map do |item, index|
      item.each_with_index.map do |_char, char_index|
        if upper_half[index][char_index] == '#' || lower_half[index][char_index] == '#'
          dots += 1
          '#'
        else
          '.'
        end
      end
    end
  else
    map.map! do |item|
      left_half = item.slice(0...line.to_i)
      right_half = item.slice(line.to_i + 1, item.length).reverse

      left_half.each_with_index.map do |_char, char_index|
        if left_half[char_index] == '#' || right_half[char_index] == '#'
          dots += 1
          '#'
        else
          '.'
        end
      end
    end
  end
end
map.each do |row|
  row.each { |char| print char }
  print "\n"
end
