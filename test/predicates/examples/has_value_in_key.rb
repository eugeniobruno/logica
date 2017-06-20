class HasValueInKey < Logica::Predicates::Base
  def initialize(field, value)
    @field = field
    @value = value
  end

  def satisfied_by?(hash)
    hash[field] == value
  end

  def disjoint_with?(other)
    other.disjoint_with_has_value_in_key?(self)
  end

  def exhaustive_with?(other)
    other.exhaustive_with_has_value_in_key?(self)
  end

  protected

  attr_reader :field, :value

  def disjoint_with_has_value_in_key?(other)
    field == other.field && value != other.value && field != :received
  end

  def exhaustive_with_has_value_in_key?(other)
    field == other.field && value != other.value && field == :received
  end
end
