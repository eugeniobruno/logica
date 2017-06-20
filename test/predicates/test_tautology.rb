require 'minitest_helper'

class TestTautology < Logica::Test
  def test_satisfied_by
    assert(tautology.satisfied_by?)
    assert(tautology.satisfied_by?('anything'))
  end

  def test_and
    assert_equal(is_even, tautology.and(is_even))
    assert_equal(is_even, is_even.and(tautology))
  end

  def test_or
    assert_equal(tautology, tautology.or(is_even))
    assert_equal(tautology, is_even.or(tautology))
  end

  def test_xor
    assert_equal(is_even.negated, tautology.xor(is_even))
    assert_equal(is_even.negated, is_even.xor(tautology))
  end

  def test_implies
    assert_equal(is_even, tautology.implies(is_even))
    assert_equal(tautology, is_even.implies(tautology))
  end

  def test_iff
    assert_equal(is_even, tautology.iff(is_even))
    assert_equal(is_even, is_even.iff(tautology))
  end

  def test_disjoint_with_basic
    assert(!tautology.disjoint_with?(is_even))
    assert(!is_even.disjoint_with?(tautology))
  end

  def test_disjoint_with_tautology
    assert(!tautology.disjoint_with?(tautology))
  end

  def test_disjoint_with_contradiction
    assert(tautology.disjoint_with?(contradiction))
  end

  def test_exhaustive_with_basic
    assert(tautology.exhaustive_with?(is_even))
    assert(is_even.exhaustive_with?(tautology))
  end

  def test_exhaustive_with_tautology
    assert(tautology.exhaustive_with?(tautology))
  end

  def test_exhaustive_with_contradiction
    assert(tautology.exhaustive_with?(contradiction))
  end

  def test_to_s
    assert_equal('TRUE |n|', tautology.to_s)
  end
end
