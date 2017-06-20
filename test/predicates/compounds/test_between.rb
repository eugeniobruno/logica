require 'minitest_helper'

class TestBetween < Logica::Test
  def test_satisfied_by
    assert(!between_one_and_two.satisfied_by?(1))  # zero
    assert( between_one_and_two.satisfied_by?(2))  # one
    assert( between_one_and_two.satisfied_by?(3))  # one
    assert( between_one_and_two.satisfied_by?(4))  # one
    assert( between_one_and_two.satisfied_by?(5))  # one
    assert( between_one_and_two.satisfied_by?(6))  # two
    assert(!between_one_and_two.satisfied_by?(7))  # zero
    assert( between_one_and_two.satisfied_by?(8))  # one
    assert( between_one_and_two.satisfied_by?(9))  # one
    assert( between_one_and_two.satisfied_by?(10)) # two
    assert(!between_one_and_two.satisfied_by?(30)) # three
  end

  def test_to_s
    assert_equal('AND(OR(IsDivisibleBy(2), IsDivisibleBy(3), IsDivisibleBy(5)), OR(NOT(IsDivisibleBy(2)), NOT(IsDivisibleBy(3)), NOT(IsDivisibleBy(5)))) |1|', between_one_and_two.to_s)
  end

  private

  def between_one_and_two
    between(1, 2, unrelated_predicates)
  end
end
