input = File.read("#{__dir__}/input.txt").split("\n").map { _1.split('') }

closing_brackets = {
  ')' => '(',
  ']' => '[',
  '>' => '<',
  '}' => '{'
}
bracket_scores = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25_137
}

# part 1
illegal_chars = []
input.each do |line|
  stack = []
  line.each do |char|
    if closing_brackets[char]
      illegal_chars.push(char) if stack.pop != closing_brackets[char]
    else
      stack.push(char)
    end
  end
end
p illegal_chars.reduce(0) { _1 + bracket_scores[_2] }

# part 2
bracket_points = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}
scores = []
input.each do |line|
  stack = []
  illegal_line = false
  line.each do |char|
    if closing_brackets[char]
      if stack.pop != closing_brackets[char]
        illegal_line = true
        break
      end
    else
      stack.push(char)
    end
  end

  unless stack.empty? || illegal_line
    scores.push stack.map { closing_brackets.key(_1) }.reverse.reduce(0) { (_1 * 5) + bracket_points[_2] }
  end
end

p scores.sort[scores.length / 2]
