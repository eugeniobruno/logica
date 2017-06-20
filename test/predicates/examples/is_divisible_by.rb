class IsDivisibleBy < Logica::Predicates::Base
  attr_reader :divisor

  def initialize(divisor)
    @divisor = divisor
  end

  def satisfied_by?(number)
    (number % divisor).zero?
  end

  def specialization_of?(other)
    other.generalization_of_is_divisible_by?(self)
  end

  def generalization_of_is_divisible_by?(is_divisible_by)
    satisfied_by?(is_divisible_by.divisor)
  end
end
