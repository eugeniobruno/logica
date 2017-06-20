require 'minitest_helper'

class TestContradiction < Logica::Test
  def test_satisfied_by
    assert(!contradiction.satisfied_by?)
    assert(!contradiction.satisfied_by?('anything'))
  end

  def test_and
    assert_equal(contradiction, contradiction.and(is_even))
    assert_equal(contradiction, is_even.and(contradiction))
  end

  def test_or
    assert_equal(is_even, contradiction.or(is_even))
    assert_equal(is_even, is_even.or(contradiction))
  end

  def test_xor
    assert_equal(is_even, contradiction.xor(is_even))
    assert_equal(is_even, is_even.xor(contradiction))
  end

  def test_implies
    assert_equal(contradiction.negated, contradiction.implies(is_even))
    assert_equal(is_even.negated, is_even.implies(contradiction))
  end

  def test_iff
    assert_equal(is_even.negated, contradiction.iff(is_even))
    assert_equal(is_even.negated, is_even.iff(contradiction))
  end

  def test_disjoint_with_basic
    assert(contradiction.disjoint_with?(is_even))
    assert(is_even.disjoint_with?(contradiction))
  end

  def test_disjoint_with_contradiction
    assert(contradiction.disjoint_with?(contradiction))
  end

  def test_disjoint_with_tautology
    assert(contradiction.disjoint_with?(tautology))
  end

  def test_exhaustive_with_basic
    assert(!contradiction.exhaustive_with?(is_even))
    assert(!is_even.exhaustive_with?(contradiction))
  end

  def test_exhaustive_with_contradiction
    assert(!contradiction.exhaustive_with?(contradiction))
  end

  def test_exhaustive_with_tautology
    assert(contradiction.exhaustive_with?(tautology))
  end

  def test_to_s
    assert_equal('FALSE |n|', contradiction.to_s)
  end

  private

  def contradiction
    is_even.and(is_even.negated)
  end
end
