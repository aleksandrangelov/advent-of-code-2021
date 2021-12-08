input = File.read("#{__dir__}/input.txt").split("\n").map { |x| x.split(' | ') }

def array_extract(arr, &block)
  (arr.dup - arr.reject!(&block)).first
end

count = input.reduce(0) do |sum, x|
  signal_patterns, output_values = x
  digit_map = {}
  signal_patterns = signal_patterns.split(' ')

  digit_map[1] = array_extract(signal_patterns) { _1.length == 2 }
  digit_map[4] = array_extract(signal_patterns) { _1.length == 4 }
  digit_map[7] = array_extract(signal_patterns) { _1.length == 3 }
  digit_map[8] = array_extract(signal_patterns) { _1.length == 7 }
  digit_map[3] = array_extract(signal_patterns) { _1.length == 5 && _1.count(digit_map[7]) == 3 }
  digit_map[9] = array_extract(signal_patterns) { _1.length == 6 && _1.count(digit_map[3]) == 5 }
  digit_map[5] = array_extract(signal_patterns) { _1.length == 5 && digit_map[9].count(_1) == 5 }
  digit_map[6] = array_extract(signal_patterns) { _1.count(digit_map[5]) == 5 && _1.length == 6 }
  digit_map[0] = array_extract(signal_patterns) { _1.length == 6 }
  digit_map[2] = signal_patterns.first

  output_digit = ''
  output_values.split(' ').each do |val|
    segment_map = digit_map.select { |_k, v| v.length == val.length }
    next if segment_map.empty?

    output_digit += segment_map.select { _2.split('').all? { |char| val.include?(char) } }.keys.first.to_s
  end

  sum + output_digit.to_i
end

p count
