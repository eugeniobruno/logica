require 'minitest_helper'

class TestBasic < Logica::Test
  def test_satisfied_by
    assert(!is_even.satisfied_by?(1))
    assert(!is_even.satisfied_by?(3))

    assert(is_even.satisfied_by?(2))
    assert(is_even.satisfied_by?(4))
  end

  def test_negated
    assert(is_odd.satisfied_by?(1))
    assert(is_odd.satisfied_by?(3))

    assert(!is_odd.satisfied_by?(2))
    assert(!is_odd.satisfied_by?(4))
  end

  def test_and
    is_greater_than_five_and_is_even = is_greater_than_five.and(is_even)

    assert(!is_greater_than_five_and_is_even.satisfied_by?(4))
    assert(!is_greater_than_five_and_is_even.satisfied_by?(5))
    assert(!is_greater_than_five_and_is_even.satisfied_by?(7))

    assert(is_greater_than_five_and_is_even.satisfied_by?(6))
    assert(is_greater_than_five_and_is_even.satisfied_by?(8))
  end

  def test_and_between_opposites
    assert_equal(contradiction, is_even.and_not(is_even))
    assert_equal(contradiction, is_even.and(is_even.negated))
    assert_equal(contradiction, is_even.negated.and(is_even))
  end

  def test_and_between_disjoints
    assert_equal(contradiction, is_greater_than(5).and_not(is_greater_than(3)))
    assert_equal(contradiction, is_greater_than(5).and(is_greater_than(3).negated))
    assert_equal(contradiction, is_greater_than(3).negated.and(is_greater_than(5)))
  end

  def test_or
    is_greater_than_five_or_is_even = is_greater_than_five.or(is_even)

    assert(!is_greater_than_five_or_is_even.satisfied_by?(3))
    assert(!is_greater_than_five_or_is_even.satisfied_by?(5))

    assert(is_greater_than_five_or_is_even.satisfied_by?(4))
    assert(is_greater_than_five_or_is_even.satisfied_by?(6))
    assert(is_greater_than_five_or_is_even.satisfied_by?(7))
  end

  def test_or_between_opposites
    assert_equal(tautology, is_even.or(is_even.negated))
    assert_equal(tautology, is_even.negated.or(is_even))
  end

  def test_or_between_exhaustives
    assert_equal(tautology, is_greater_than(3).or(is_less_than(5)))
  end

  def test_xor
    is_greater_than_five_xor_is_even = is_greater_than_five.xor(is_even)

    assert(!is_greater_than_five_xor_is_even.satisfied_by?(3))
    assert(!is_greater_than_five_xor_is_even.satisfied_by?(5))
    assert(!is_greater_than_five_xor_is_even.satisfied_by?(6))

    assert(is_greater_than_five_xor_is_even.satisfied_by?(4))
    assert(is_greater_than_five_xor_is_even.satisfied_by?(7))
  end

  def test_implies
    is_greater_than_five_implies_is_even = is_greater_than_five.implies(is_even)

    assert(is_greater_than_five_implies_is_even.satisfied_by?(3))
    assert(is_greater_than_five_implies_is_even.satisfied_by?(5))
    assert(is_greater_than_five_implies_is_even.satisfied_by?(6))

    assert(is_greater_than_five_implies_is_even.satisfied_by?(4))
    assert(!is_greater_than_five_implies_is_even.satisfied_by?(7))
  end

  def test_iff
    is_greater_than_five_iff_is_even = is_greater_than_five.iff(is_even)

    assert(is_greater_than_five_iff_is_even.satisfied_by?(3))
    assert(is_greater_than_five_iff_is_even.satisfied_by?(5))
    assert(is_greater_than_five_iff_is_even.satisfied_by?(6))

    assert(!is_greater_than_five_iff_is_even.satisfied_by?(4))
    assert(!is_greater_than_five_iff_is_even.satisfied_by?(7))
  end

  def test_specialization_of_itself
    assert(is_even.specialization_of?(is_even))
  end

  def test_arity
    assert_equal(1, is_even.arity)
    assert_equal(1, is_greater_than_five.arity)
  end

  def test_to_proc
    assert([1, 2, 3].any?(&is_even))
    assert([1, 2, 3].none?(&is_greater_than_five))
  end

  def test_to_s
    assert_equal('IsDivisibleBy(2) |1|', is_even.to_s)
    assert_equal('IsGreaterThan(5) |1|', is_greater_than_five.to_s)
  end

  private

  def is_greater_than_five
    is_greater_than(5)
  end
end
