require 'minitest_helper'

class TestAtMost < Logica::Test
  def test_satisfied_by
    assert( at_most_two.satisfied_by?(1))  # zero
    assert( at_most_two.satisfied_by?(2))  # one
    assert( at_most_two.satisfied_by?(3))  # one
    assert( at_most_two.satisfied_by?(4))  # one
    assert( at_most_two.satisfied_by?(5))  # one
    assert( at_most_two.satisfied_by?(6))  # two
    assert( at_most_two.satisfied_by?(7))  # zero
    assert( at_most_two.satisfied_by?(8))  # one
    assert( at_most_two.satisfied_by?(9))  # one
    assert( at_most_two.satisfied_by?(10)) # two
    assert(!at_most_two.satisfied_by?(30)) # three
  end

  def test_to_s
    assert_equal('OR(NOT(IsDivisibleBy(2)), NOT(IsDivisibleBy(3)), NOT(IsDivisibleBy(5))) |1|', at_most_two.to_s)
  end
end
