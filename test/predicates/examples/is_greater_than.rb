class IsGreaterThan < Logica::Predicates::Base
  attr_reader :threshold

  def initialize(threshold)
    @threshold = threshold
  end

  def satisfied_by?(number)
    number > threshold
  end

  def specialization_of?(other)
    other.generalization_of_is_greater_than?(self)
  end

  def generalization_of_is_greater_than?(is_greater_than)
    threshold <= is_greater_than.threshold
  end

  def exhaustive_with?(other)
    other.exhaustive_with_is_greater_than?(self)
  end

  def exhaustive_with_is_less_than?(is_less_than)
    threshold < is_less_than.threshold
  end
end
