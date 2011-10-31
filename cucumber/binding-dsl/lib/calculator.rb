class Calculator
  def initialize
    @numbers = []
  end

  def push(n)
    @numbers << n
  end

  def add
    sum = @numbers.reduce(:+)
    @numbers.clear
    
    sum
  end
end
