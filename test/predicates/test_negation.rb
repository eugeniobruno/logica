require 'minitest_helper'

class TestNegation < Logica::Test
  def test_negation
    assert( is_odd.satisfied_by?(1))
    assert(!is_odd.satisfied_by?(2))
  end

  def test_double_negation
    assert_equal(is_even, is_odd.negated)
  end

  def test_portion_satisfied_by
    assert_equal(tautology, is_odd.portion_satisfied_by(2))
    assert_equal(is_odd, is_odd.portion_satisfied_by(3))
  end

  def test_remainder_unsatisfied_by
    assert_equal(is_odd, is_odd.remainder_unsatisfied_by(2))
    assert_equal(contradiction, is_odd.remainder_unsatisfied_by(3))
  end

  def test_arity
    assert_equal(1, is_odd.arity)
  end

  def test_to_s
    assert_equal('NOT(IsDivisibleBy(2)) |1|', is_odd.to_s)
  end
end
