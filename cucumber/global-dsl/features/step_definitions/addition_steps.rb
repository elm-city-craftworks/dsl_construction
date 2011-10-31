require_relative "../../lib/calculator"

step /I have entered (\d+) into the calculator/ do |n|
  @calculator ||= Calculator.new

  @calculator.push(n.to_i)
end

step /I press add/ do
  @result = @calculator.add
end

step /the result should be (\d+)/ do |n|
  abort "Expected #{n}, got #{@result}" unless @result == n.to_i
end
