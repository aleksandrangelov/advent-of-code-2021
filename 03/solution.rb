input = File.read("#{__dir__}/input.txt").split("\n").map { |binary| binary.split('') }

gamma = Array.new(input[0].length, 0)

input.each do |x|
  x.each_with_index do |y, yi|
    if (y.to_i) == 1
      gamma[yi] += 1
    else
      gamma[yi] -= 1
    end
  end
end

gamma = gamma.map do |n|
  n.negative? ? 0 : 1
end

epsilon = (gamma.join.to_i(2) ^ Array.new(input[0].length, 1).join.to_i(2)).to_s(2)
p(gamma.join.to_i(2) * epsilon.to_i(2))

oxygen_generator_rating = input.clone
char_index = 0
occurances = Array.new(input[0].length, 0)

while oxygen_generator_rating.length > 1
  oxygen_generator_rating.each do |row|
    num = row[char_index].to_i
    if num == 1
      occurances[char_index] += 1
    else
      occurances[char_index] -= 1
    end
  end

  occurances[char_index] = occurances[char_index].negative? ? 0 : 1
  oxygen_generator_rating.select! { |binary| binary[char_index].to_i == occurances[char_index] }
  char_index += 1
end

p oxygen_generator_rating

char_index = 0
co2_scrubber_rating = input.clone
occurances = Array.new(input[0].length, 0)
while co2_scrubber_rating.length > 1
  co2_scrubber_rating.each do |row|
    num = row[char_index].to_i
    if num == 1
      occurances[char_index] += 1
    else
      occurances[char_index] -= 1
    end
  end

  occurances[char_index] = occurances[char_index].negative? ? 0 : 1
  co2_scrubber_rating.reject! { |binary| binary[char_index].to_i == occurances[char_index] }
  char_index += 1
end

p(co2_scrubber_rating[0].join.to_i(2) * oxygen_generator_rating[0].join.to_i(2))
