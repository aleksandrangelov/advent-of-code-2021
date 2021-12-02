input = File.read("#{__dir__}/input.txt").split("\n").map(&:to_i)

p(input.each_cons(2).count { |x, y| x < y })
p(input.each_cons(3).map { |arr| arr.reduce(:+) }.each_cons(2).count { |x, y| x < y })
