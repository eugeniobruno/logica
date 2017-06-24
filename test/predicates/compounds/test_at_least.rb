require 'minitest_helper'

class TestAtLeast < Logica::Test
  def test_satisfied_by
    assert(!at_least_two.satisfied_by?(1))  # zero
    assert(!at_least_two.satisfied_by?(2))  # one
    assert(!at_least_two.satisfied_by?(3))  # one
    assert(!at_least_two.satisfied_by?(4))  # one
    assert(!at_least_two.satisfied_by?(5))  # one
    assert( at_least_two.satisfied_by?(6))  # two
    assert(!at_least_two.satisfied_by?(7))  # zero
    assert(!at_least_two.satisfied_by?(8))  # one
    assert(!at_least_two.satisfied_by?(9))  # one
    assert( at_least_two.satisfied_by?(10)) # two
    assert( at_least_two.satisfied_by?(30)) # three
  end

  def test_and_with_other1
    expected = divisibility_by(3).or(divisibility_by(5)).and(divisibility_by(2))
    actual = at_least_two.and(unrelated_predicates[0])

    assert_equal expected, actual
  end

  def test_and_with_other2
    expected = divisibility_by(2).and(divisibility_by(3).or(divisibility_by(5)))
    actual = unrelated_predicates[0].and(at_least_two)

    assert_equal expected, actual
  end

  def test_and_with_other3
    expected = divisibility_by(15)
    actual = at_least_two.and(divisibility_by(15))

    assert_equal expected, actual
  end

  def test_and_with_other4
    expected = divisibility_by(15)
    actual = divisibility_by(15).and(at_least_two)

    assert_equal expected, actual
  end

  def test_degeneration_to_tautology
    assert_equal(tautology, at_least(0, unrelated_predicates))
  end

  def test_degeneration_to_disjunction
    expected = disjunction(unrelated_predicates)
    actual = at_least(1, unrelated_predicates)

    assert_equal expected, actual
  end

  def test_degeneration_to_conjunction
    expected = conjunction(unrelated_predicates)
    actual = at_least(3, unrelated_predicates)

    assert_equal expected, actual
  end

  def test_degeneration_to_contradiction
    assert_equal(contradiction, at_least(4, unrelated_predicates))
  end

  def test_specialization_of_itself
    assert(at_least_two.specialization_of?(at_least_two))
  end

  def test_to_disjunction
    conjuntion1 = unrelated_predicates[0].and(unrelated_predicates[1])
    conjuntion2 = unrelated_predicates[0].and(unrelated_predicates[2])
    conjuntion3 = unrelated_predicates[1].and(unrelated_predicates[2])

    expected = disjunction([conjuntion1, conjuntion2, conjuntion3])
    actual = at_least_two.to_disjunction

    assert_equal expected, actual
  end

  def test_to_s
    assert_equal('AtLeast(2, [IsDivisibleBy(2), IsDivisibleBy(3), IsDivisibleBy(5)]) |1|', at_least_two.to_s)
  end

  def test_method_missing
    assert_raises(NoMethodError) do
      at_least_two.foo
    end
  end
end
