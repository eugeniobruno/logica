require 'minitest_helper'

class TestExactly < Logica::Test
  def test_satisfied_by
    assert(!exactly_two.satisfied_by?(1))  # zero
    assert(!exactly_two.satisfied_by?(2))  # one
    assert(!exactly_two.satisfied_by?(3))  # one
    assert(!exactly_two.satisfied_by?(4))  # one
    assert(!exactly_two.satisfied_by?(5))  # one
    assert( exactly_two.satisfied_by?(6))  # two
    assert(!exactly_two.satisfied_by?(7))  # zero
    assert(!exactly_two.satisfied_by?(8))  # one
    assert(!exactly_two.satisfied_by?(9))  # one
    assert( exactly_two.satisfied_by?(10)) # two
    assert(!exactly_two.satisfied_by?(30)) # three
  end

  def test_to_s
    assert_equal('AND(AtLeast(2, [IsDivisibleBy(2), IsDivisibleBy(3), IsDivisibleBy(5)]), OR(NOT(IsDivisibleBy(2)), NOT(IsDivisibleBy(3)), NOT(IsDivisibleBy(5)))) |1|', exactly_two.to_s)
  end
end
