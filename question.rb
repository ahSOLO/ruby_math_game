class Question
  MIN = 1
  MAX = 20

  attr_accessor :num1, :num2, :sum

  def initialize
    self.num1 = rand(MIN..MAX)
    self.num2 = rand(MIN..MAX)
    self.sum = self.num1 + self.num2
  end
end