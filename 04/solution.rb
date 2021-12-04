input = File.read("#{__dir__}/input.txt").gsub(/^$\n/, '').split("\n")
bingo_numbers = input.shift.split(',')
boards = input.each_slice(5).map { _1.map { |board| board.split(' ') } }
bingo = false
last_drawn_num = nil
last_winning_board = nil
number_index = 0
winning_boards = []

while winning_boards.length != boards.length
  last_drawn_num = bingo_numbers[number_index]

  boards.each_with_index do |board, _board_index|
    next if winning_boards.include? _board_index

    bingo = false

    board.each_with_index do |row, _row_index|
      break if bingo

      row.each_with_index do |col, _col_index|
        board[_row_index][_col_index] = ' ' if col == last_drawn_num

        next unless board.any? { _1.all?(' ') } || board.transpose.any? { _1.all?(' ') }

        last_winning_board = board
        winning_boards.push(_board_index)
        bingo = true
        break
      end
    end
  end
  number_index += 1
end

winning_board_sum = 0

last_winning_board.each do |row|
  row.each { |num| winning_board_sum += num.to_i if num != ' ' }
end

p last_drawn_num
p winning_board_sum * last_drawn_num.to_i
